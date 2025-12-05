#!/usr/bin/env bash
set -euo pipefail

# Check for --dry-run flag
DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
    STOW_FLAGS="-n"
    echo "=== DRY RUN MODE - No changes will be made ==="
else
    STOW_FLAGS=""
fi

# Load install mode configuration
HEADLESS_BASIC_GUI=false
if [ -f "home/.config/rsh-shell-config/install/install-mode" ]; then
    source "home/.config/rsh-shell-config/install/install-mode"
fi

# Stow home directory files
if [ "$DRY_RUN" = true ]; then
    echo "Would stow home directory files..."
fi

# Add ignore flags for GUI-specific files in headless mode
IGNORE_FLAGS=""
if [ "$HEADLESS_BASIC_GUI" = true ]; then
    IGNORE_FLAGS="--ignore=niri --ignore=swayidle.service --ignore=swaylock"
fi

stow $STOW_FLAGS $IGNORE_FLAGS -t ~ home

# Only stow to /etc if there are differences (skip in headless mode)
if [ "$HEADLESS_BASIC_GUI" = false ]; then
    # Check if files in etc/ differ from their symlink targets in /etc
    needs_update=false
    while IFS= read -r -d '' file; do
        rel_path="${file#etc/}"
        target="/etc/$rel_path"
        source_file="$(pwd)/etc/$rel_path"

        # Check if target doesn't exist or isn't a symlink
        if [[ ! -L "$target" ]]; then
            needs_update=true
            break
        fi

        # Resolve the symlink and compare to source
        actual_target="$(readlink -f "$target")"
        if [[ "$actual_target" != "$source_file" ]]; then
            needs_update=true
            break
        fi

        # Check if file content differs (in case symlink is correct but content changed)
        if [[ -f "$file" ]] && ! cmp -s "$file" "$target"; then
            needs_update=true
            break
        fi
    done < <(find etc -type f -print0)

    if $needs_update; then
        if [ "$DRY_RUN" = true ]; then
            echo "Would run: sudo stow -t /etc etc"
            sudo stow -n -t /etc etc
        else
            echo "Changes detected in /etc, running sudo stow..."
            sudo stow -t /etc etc
        fi
    else
        echo "No changes in /etc, skipping sudo stow"
    fi
else
    echo "Headless mode: skipping /etc config (keyd)"
fi

# Enable systemd user services (skip in headless mode)
if [ "$HEADLESS_BASIC_GUI" = false ]; then
    if [ "$DRY_RUN" = true ]; then
        echo "Would enable and start systemd user services..."
    else
        # Reload systemd user daemon to pick up new service files
        systemctl --user daemon-reload

        # Enable swayidle service if it exists
        if [ -f "$HOME/.config/systemd/user/swayidle.service" ]; then
            echo "Enabling swayidle.service..."
            systemctl --user enable swayidle.service
            systemctl --user restart swayidle.service
        fi
    fi
fi

