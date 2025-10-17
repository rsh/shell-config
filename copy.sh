#!/usr/bin/env bash

# Stow home directory files
stow -t ~ home

# Only stow to /etc if there are differences
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
    echo "Changes detected in /etc, running sudo stow..."
    sudo stow -t /etc etc
else
    echo "No changes in /etc, skipping sudo stow"
fi

