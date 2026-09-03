#!/bin/bash
# Rasterise les SVG de _tools/svg-about vers About/.
# Chrome headless sert de rasteriseur : aucun rasteriseur SVG n'est installe sur la machine.
# La fenetre doit faire exactement la taille declaree par le SVG, sinon la capture est rognee.
set -e
cd "$(dirname "$0")/.."
CH="/c/Program Files/Google/Chrome/Application/chrome.exe"
B="$(pwd -W 2>/dev/null || pwd)"
mkdir -p About
for f in _tools/svg-about/*.svg; do
  n=$(basename "$f" .svg)
  w=$(grep -o 'width="[0-9]*"' "$f" | head -1 | tr -dc 0-9)
  h=$(grep -o 'height="[0-9]*"' "$f" | head -1 | tr -dc 0-9)
  "$CH" --headless --no-sandbox --disable-gpu --hide-scrollbars --window-size="$w,$h" \
    --default-background-color=00000000 \
    --screenshot="$B/About/$n.png" "file:///$B/_tools/svg-about/$n.svg" >/dev/null 2>&1
done
ls -l About
