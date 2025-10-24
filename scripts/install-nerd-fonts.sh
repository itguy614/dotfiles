#!/bin/sh

brew search '/font-.*-(nerd-font|nf)/' \
| awk '{print $1}' \
| sort -u \
| while read -r font; do
  if brew list --cask "$font" >/dev/null 2>&1; then
    echo "Already installed: $font"
    continue
  fi

  echo "Installing: $font"
  if ! brew install --cask "$font"; then
    echo "⚠️  Failed to install $font — skipping"
  fi
done

