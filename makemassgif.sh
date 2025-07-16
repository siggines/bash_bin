#!/bin/bash

echo "Enter start time in seconds (e.g., 9):"
read start

echo "Enter end time in seconds (e.g., 12):"
read end

duration=$(echo "$end - $start" | bc)
fps=15
scale_width=480

for input in *.mp4 *.webm; do
  [ -f "$input" ] || continue  # skip if no match
  base="${input%.*}"
  output="${base}.gif"
  
  echo "Processing $input → $output"

  # Generate palette
  ffmpeg -v warning -ss "$start" -t "$duration" -i "$input" \
    -vf "fps=$fps,scale=${scale_width}:-1:flags=lanczos,palettegen" \
    "${base}_palette.png"

  # Generate GIF
  ffmpeg -v warning -ss "$start" -t "$duration" -i "$input" -i "${base}_palette.png" \
    -filter_complex "fps=$fps,scale=${scale_width}:-1:flags=lanczos[x];[x][1:v]paletteuse" \
    "$output"

  # Clean up
  rm "${base}_palette.png"
  echo "Saved $output"
done
