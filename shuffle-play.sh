#!/bin/bash
files=(*.flac *.mp3)
shuf -e "${files[@]}" | while read -r file; do
mpv --loop-file=0 --no-audio-display -- "$file"
done
