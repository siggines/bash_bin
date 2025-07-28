#!/bin/bash

MAX_SIZE=8388608  # 8MB in bytes
TARGET_WIDTH=1920

for file in *.{jpg,jpeg,png}; do
[ -e "$file" ] || continue

FILESIZE=$(stat -c%s "$file")
if [ "$FILESIZE" -gt "$MAX_SIZE" ]; then
echo "Resizing $file (size: $((FILESIZE / 1024 / 1024)) MB)"

        # Extract extension
ext="${file##*.}"

        # Resize to temp file with proper extension
tmpfile="${file}.tmp.${ext}"

ffmpeg -y -i "$file" -vf "scale='min($TARGET_WIDTH,iw)':-2" "$tmpfile" && mv "$tmpfile" "$file"
fi
done
