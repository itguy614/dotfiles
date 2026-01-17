#!/bin/bash

# Status line script for Claude Code
# Matches the Gallifrey zsh theme style
# Format: hostname current_dir ‹git_branch› [model] »

# Read JSON from stdin
input=$(cat)

# Extract values from JSON
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // .model.id // empty')

# Fallback if no directory provided
if [[ -z "$cwd" ]]; then
    cwd=$(pwd)
fi

# Get hostname
hostname=$(hostname -s)

# Get last 2 directory levels (matching %2~ from gallifrey theme)
# If we're in the home directory, show ~
if [[ "$cwd" == "$HOME" ]]; then
    short_dir="~"
elif [[ "$cwd" == "$HOME/"* ]]; then
    # Replace home with ~ and get last 2 levels
    relative_path="${cwd#$HOME/}"
    # Count slashes to determine depth
    slash_count=$(echo "$relative_path" | tr -cd '/' | wc -c)
    if [[ $slash_count -ge 1 ]]; then
        short_dir="~/$(echo "$relative_path" | rev | cut -d'/' -f1,2 | rev)"
    else
        short_dir="~/$relative_path"
    fi
else
    # Get last 2 levels for non-home paths
    short_dir=$(echo "$cwd" | rev | cut -d'/' -f1,2 | rev)
fi

# Get git branch if in a git repository
git_branch=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
    if [[ -n "$branch" ]]; then
        # Yellow brackets around branch name (using ANSI codes)
        git_branch=$(printf "\033[33m‹%s›\033[0m " "$branch")
    fi
fi

# Green hostname + directory + git info + model + prompt character
# Matching gallifrey theme style: hostname dir ‹branch› [model] »
if [[ -n "$model" ]]; then
    printf "\033[32m%s\033[0m %s %s\033[36m[%s]\033[0m \033[1m»\033[0m" "$hostname" "$short_dir" "$git_branch" "$model"
else
    printf "\033[32m%s\033[0m %s %s\033[1m»\033[0m" "$hostname" "$short_dir" "$git_branch"
fi
