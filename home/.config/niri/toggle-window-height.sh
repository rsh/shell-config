#!/bin/bash
# Toggle window height between 100% and default
# Intelligently detects current state by querying actual window geometry

# Get window and output information
window_info=$(niri msg --json windows)
output_info=$(niri msg --json outputs)

# Get the focused window's height
window_height=$(echo "$window_info" | jq -r '
  .[] |
  select(.is_focused == true) |
  .layout.window_size[1]
')

if [ -z "$window_height" ] || [ "$window_height" = "null" ]; then
    echo "Could not determine window dimensions" >&2
    exit 1
fi

# Get the output logical height (find the output with logical coordinates)
output_height=$(echo "$output_info" | jq -r '
  .[] |
  select(.logical != null) |
  .logical.height
' | head -1)

if [ -z "$output_height" ] || [ "$output_height" = "null" ]; then
    echo "Could not determine output height" >&2
    exit 1
fi

# Calculate current height percentage relative to output
# Consider it "maximized" if >= 95% of output height
current_percentage=$(awk "BEGIN {printf \"%.0f\", ($window_height / $output_height) * 100}")

if [ "$current_percentage" -ge 95 ]; then
    # Currently maximized, reset to default
    niri msg action reset-window-height
else
    # Not maximized, set to 100%
    niri msg action set-window-height "100%"
fi
