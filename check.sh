#!/usr/bin/env bash
set -euo pipefail

# check.sh - Validate all shell scripts in the repository
# Runs shellcheck on all bash/sh scripts and reports any issues

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=== Shell Script Validation ==="
echo ""

# Track results
total_scripts=0
passed_scripts=0
failed_scripts=0
skipped_scripts=0

# Find all shell scripts (excluding .git directory)
mapfile -t scripts < <(find . -type f \( -name "*.sh" -o -name "*.bash" \) -not -path "./.git/*" | sort)

# Also check scripts in home/bin that don't have extensions
if [ -d "home/bin" ]; then
    while IFS= read -r file; do
        # Check if file is executable and has a bash/sh shebang
        if [ -x "$file" ] && head -1 "$file" 2>/dev/null | grep -qE '^#!/.*(bash|sh)'; then
            scripts+=("$file")
        fi
    done < <(find home/bin -type f ! -name "*.py" ! -name "*.md" ! -name "*.txt" | sort)
fi

# Remove duplicates and sort
mapfile -t scripts < <(printf '%s\n' "${scripts[@]}" | sort -u)

echo "Found ${#scripts[@]} shell script(s) to check"
echo ""

# Check each script
for script in "${scripts[@]}"; do
    total_scripts=$((total_scripts + 1))

    # Check if it's a zsh script (shellcheck doesn't support zsh)
    if head -1 "$script" 2>/dev/null | grep -q 'zsh'; then
        echo -e "${YELLOW}SKIP${NC} $script (zsh not supported by shellcheck)"
        skipped_scripts=$((skipped_scripts + 1))
        continue
    fi

    # Check if it's a Python script (skip)
    if head -1 "$script" 2>/dev/null | grep -q 'python'; then
        echo -e "${YELLOW}SKIP${NC} $script (Python script)"
        skipped_scripts=$((skipped_scripts + 1))
        continue
    fi

    # Run shellcheck
    if shellcheck "$script" 2>&1; then
        echo -e "${GREEN}PASS${NC} $script"
        passed_scripts=$((passed_scripts + 1))
    else
        echo -e "${RED}FAIL${NC} $script"
        failed_scripts=$((failed_scripts + 1))
        echo ""
    fi
done

echo ""
echo "=== Summary ==="
echo "Total scripts: $total_scripts"
echo -e "${GREEN}Passed: $passed_scripts${NC}"
echo -e "${RED}Failed: $failed_scripts${NC}"
echo -e "${YELLOW}Skipped: $skipped_scripts${NC}"
echo ""

# Exit with error if any scripts failed
if [ $failed_scripts -gt 0 ]; then
    echo -e "${RED}❌ Some scripts have issues that need to be fixed${NC}"
    exit 1
else
    echo -e "${GREEN}✅ All shell scripts are valid!${NC}"
    exit 0
fi
