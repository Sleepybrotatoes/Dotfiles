#!/bin/bash

# Get CPU usage percentage
usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}' | awk '{print int($1)}')

# Cap at 100
if [ "$usage" -gt 100 ]; then usage=100; fi

# ASCII bar logic
filled=$((usage / 10))
empty=$((10 - filled))

# Robust bar generation
bar=""; for ((i=0; i<filled; i++)); do bar+="█"; done
pad=""; for ((i=0; i<empty; i++)); do pad+="░"; done

# Color logic
if [ "$usage" -lt 50 ]; then
    fg="#abe9b3" # Green
elif [ "$usage" -lt 80 ]; then
    fg="#fae3b0" # Yellow
else
    fg="#f28fad" # Red
fi

# Final JSON output
cat <<EOF
{"text":"<span foreground='$fg'> [$bar$pad] $usage%</span>", "tooltip":"CPU Usage: $usage%"}
EOF
