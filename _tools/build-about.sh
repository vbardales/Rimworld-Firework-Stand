#!/bin/bash
# Rasterises the SVG files in _tools/svg-about into Mod/About/.
# Chrome headless is the rasteriser: no SVG rasteriser is installed on this machine.
# The window must match the size declared by the SVG exactly, or the capture is cropped.
set -e
cd "$(dirname "$0")/.."
CH="/c/Program Files/Google/Chrome/Application/chrome.exe"
B="$(pwd -W 2>/dev/null || pwd)"
mkdir -p Mod/About
for f in _tools/svg-about/*.svg; do
  n=$(basename "$f" .svg)
  w=$(grep -o 'width="[0-9]*"' "$f" | head -1 | tr -dc 0-9)
  h=$(grep -o 'height="[0-9]*"' "$f" | head -1 | tr -dc 0-9)
  "$CH" --headless --no-sandbox --disable-gpu --hide-scrollbars --window-size="$w,$h" \
    --default-background-color=00000000 \
    --screenshot="$B/Mod/About/$n.png" "file:///$B/_tools/svg-about/$n.svg" >/dev/null 2>&1
done
ls -l Mod/About
