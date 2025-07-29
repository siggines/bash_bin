#!/bin/bash
shuf -e *.flac *.mp3 | while read -r file; do
mpv --loop-file=0 --no-audio-display -- "$file"
done
