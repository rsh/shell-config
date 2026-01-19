#!/bin/bash
# Niri workspace startup script
# Opens workspaces with terminals running tmux sessions

# Function to open a folder in a workspace with a tmux session
# Usage: open_workspace <workspace_number> <folder_path> <session_name>
open_workspace() {
    local workspace=$1
    local folder=$2
    local session=$3

    # Focus the target workspace
    niri msg action focus-workspace "$workspace"
    sleep 0.3

    # Get current total window count
    local initial_total
    initial_total=$(niri msg -j windows | jq 'length')

    # Launch the terminal
    alacritty -e bash -c "cd \"$folder\" && exec tmux new-session -A -s \"$session\"" &

    # Wait for the window to actually appear (max 3 seconds)
    local timeout=60
    local count=0
    while [ $count -lt $timeout ]; do
        local current_total
        current_total=$(niri msg -j windows | jq 'length')
        if [ "$current_total" -gt "$initial_total" ]; then
            # A new window appeared somewhere - check if it's on the right workspace
            sleep 0.2
            local window_workspace
            window_workspace=$(niri msg -j windows | jq -r '.[-1].workspace_id')

            if [ "$window_workspace" != "$workspace" ]; then
                # Window appeared on wrong workspace - move it
                niri msg action focus-window-down  # Focus the new window
                niri msg action move-column-to-workspace "$workspace"
                niri msg action focus-workspace "$workspace"
                sleep 0.2
            fi
            return 0
        fi
        sleep 0.05
        count=$((count + 1))
    done

    # Fallback: if we timed out, just wait a bit longer
    sleep 0.5
}

# Wait for niri to be ready
sleep 1

# Open configured workspaces
open_workspace 1 "/home/rayhan/notes" "notes"
open_workspace 2 "/home/rayhan/dev/shell-config" "shell-config"

# Return to workspace 1
niri msg action focus-workspace 1
