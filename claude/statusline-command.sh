#!/usr/bin/env bash
# Claude Code status line — gallifrey theme inspired
# Layout: hostname  last-2-dirs  ‹git-branch›  |  model  [context-bar]
input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
[ -z "$cwd" ] && cwd="$PWD"

# ANSI escape shorthand
ESC=$'\033'

# Replicate zsh %2~ — last 2 path components, collapse $HOME to ~
home="$HOME"
short_path="${cwd/#$home/~}"
# Keep last 2 components
short_path=$(echo "$short_path" | awk -F'/' '{
    n=NF
    if (n <= 2) { print $0 }
    else { print $(n-1)"/"$n }
}')

# Git branch (skip optional locks to avoid blocking)
git_branch=""
if git_dir=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" rev-parse --git-dir 2>/dev/null); then
    branch=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null \
             || GIT_OPTIONAL_LOCKS=0 git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
    [ -n "$branch" ] && git_branch=" ${ESC}[33m‹${branch}›${ESC}[0m"
fi

# Model display name
model=$(echo "$input" | jq -r '.model.display_name // empty')

# Context window — build a visual bar when usage is available
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

context_segment=""
if [ -n "$model" ] || [ -n "$used_pct" ]; then
    context_segment=" ${ESC}[90m|${ESC}[0m"

    if [ -n "$model" ]; then
        context_segment="${context_segment} ${ESC}[36m${model}${ESC}[0m"
    fi

    if [ -n "$used_pct" ]; then
        # Build a 10-block bar  (each block = 10%)
        filled=$(echo "$used_pct" | awk '{printf "%d", int($1 / 10 + 0.5)}')
        [ "$filled" -gt 10 ] && filled=10
        empty=$((10 - filled))

        bar=""
        for i in $(seq 1 "$filled"); do bar="${bar}█"; done
        for i in $(seq 1 "$empty");  do bar="${bar}░"; done

        # Color the bar: green ≤60 %, yellow ≤85 %, red >85 %
        bar_color="${ESC}[32m"   # green
        if [ "$(echo "$used_pct > 85" | bc 2>/dev/null)" = "1" ]; then
            bar_color="${ESC}[31m"   # red
        elif [ "$(echo "$used_pct > 60" | bc 2>/dev/null)" = "1" ]; then
            bar_color="${ESC}[33m"   # yellow
        fi

        pct_label=$(printf "%.0f%%" "$used_pct")
        context_segment="${context_segment} ${bar_color}${bar}${ESC}[0m ${ESC}[90m${pct_label}${ESC}[0m"
    fi
fi

printf "${ESC}[32m%s${ESC}[0m %s%s%s" "$(hostname -s)" "$short_path" "$git_branch" "$context_segment"
