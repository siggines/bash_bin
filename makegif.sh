#!/bin/bash

echo "Enter input video filename (include extension):"
read input

if [ ! -f "$input" ]; then
  echo "File not found!"
  exit 1
fi

echo "Enter start time in seconds (e.g., 9):"
read start

echo "Enter end time in seconds (e.g., 12):"
read end

duration=$(echo "$end - $start" | bc)

echo "Enter output GIF filename (don't include extension):"
read output

# Optional: adjust scale and fps here
fps=15
scale_width=480

# Generate palette
ffmpeg -v warning -ss $start -t $duration -i "$input" -vf "fps=$fps,scale=${scale_width}:-1:flags=lanczos,palettegen" palette.png

# Generate GIF using palette
ffmpeg -v warning -ss $start -t $duration -i "$input" -i palette.png -filter_complex "fps=$fps,scale=${scale_width}:-1:flags=lanczos[x];[x][1:v]paletteuse" "$output".gif

# Clean up palette
rm palette.png

echo "GIF saved as $output"
