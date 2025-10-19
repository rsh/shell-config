#!/bin/bash
# Niri workspace startup script
# Opens workspaces with terminals running tmux sessions

# Function to open a folder in a workspace with a tmux session
# Usage: open_workspace <workspace_number> <folder_path> <session_name>
open_workspace() {
    local workspace=$1
    local folder=$2
    local session=$3

    niri msg action focus-workspace "$workspace"
    sleep 0.3
    alacritty -e bash -c "cd \"$folder\" && exec tmux new-session -A -s \"$session\"" &
    sleep 0.5
}

# Wait for niri to be ready
sleep 1

# Open configured workspaces
open_workspace 1 "/home/rayhan/notes" "notes"
open_workspace 2 "/home/rayhan/dev/shell-config" "shell-config"

# Return to workspace 1
niri msg action focus-workspace 1
