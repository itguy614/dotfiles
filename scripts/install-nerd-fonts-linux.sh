#!/bin/bash
# Install all Nerd Fonts on Linux from the official GitHub releases
# Fonts are installed to ~/.local/share/fonts

set -euo pipefail

FONT_DIR="$HOME/.local/share/fonts/NerdFonts"
REPO="ryanoasis/nerd-fonts"
TEMP_DIR=$(mktemp -d)

trap 'rm -rf "$TEMP_DIR"' EXIT

mkdir -p "$FONT_DIR"

# Get latest release tag
echo "Fetching latest Nerd Fonts release..."
LATEST=$(curl -sI "https://github.com/$REPO/releases/latest" | grep -i '^location:' | sed 's/.*tag\///' | tr -d '\r')
echo "Latest release: $LATEST"

# Get all font archive names from the release
curl -s "https://api.github.com/repos/$REPO/releases/tags/$LATEST" \
| grep '"name":' \
| grep '\.tar\.xz' \
| sed 's/.*"name": "//;s/".*//' \
| while read -r archive; do
  font_name="${archive%.tar.xz}"

  if [ -d "$FONT_DIR/$font_name" ] && [ "$(ls -A "$FONT_DIR/$font_name" 2>/dev/null)" ]; then
    echo "Already installed: $font_name"
    continue
  fi

  echo "Installing: $font_name"
  url="https://github.com/$REPO/releases/download/$LATEST/$archive"

  if curl -sL "$url" -o "$TEMP_DIR/$archive"; then
    mkdir -p "$FONT_DIR/$font_name"
    tar -xf "$TEMP_DIR/$archive" -C "$FONT_DIR/$font_name"
    rm -f "$TEMP_DIR/$archive"
  else
    echo "  Failed to download $font_name -- skipping"
  fi
done

# Refresh font cache
echo "Refreshing font cache..."
fc-cache -f "$FONT_DIR"

echo "Done! Nerd Fonts installed to $FONT_DIR"
