#!/bin/bash
mkdir -p screenshots
for file in *.mp4 *.mkv *.avi *.webm; do
[ -e "$file" ] || continue
d=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$file")
d=${d%.*}
int=40
c=$((d/int))
for ((i=1;i<=c;i++)); do
t=$((i*int))
ffmpeg -hide_banner -loglevel error -ss "$t" -i "$file" -vframes 1 -vf "crop='ih*4/3:ih'" -q:v 2 "screenshots/${file%.*}_ss${i}.jpg"
done
done
