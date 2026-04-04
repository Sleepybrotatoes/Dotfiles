#!/bin/bash

# Get RAM usage percentage
usage=$(free | grep Mem | awk '{print int($3/$2 * 100)}')

# Cap at 100
if [ "$usage" -gt 100 ]; then usage=100; fi

# ASCII bar logic
filled=$((usage / 10))
empty=$((10 - filled))

# Robust bar generation
bar=""; for ((i=0; i<filled; i++)); do bar+="█"; done
pad=""; for ((i=0; i<empty; i++)); do pad+="░"; done

# Color logic
if [ "$usage" -lt 70 ]; then
    fg="#96cdfb" # Blue
else
    fg="#f28fad" # Red
fi

# Final JSON output
cat <<EOF
{"text":"<span foreground='$fg'> [$bar$pad] $usage%</span>", "tooltip":"RAM Usage: $usage%"}
EOF
