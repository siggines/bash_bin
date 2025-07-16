#!/bin/bash

# Prompt user for the text to overlay
echo "Enter the text you want to overlay on the video:"
read input_text

# Prompt user for the base name or a part of the file name
echo "Enter the beginning of the video file name (or full name) (preview_ will be added after):"
read file_prefix

# Find a file that starts with the provided prefix (first word)
input_file=$(find . -maxdepth 1 -type f -iname "preview_${file_prefix}*" -print -quit)

# Check if the file was found
if [ -z "$input_file" ]; then
    echo "No file found that starts with '$file_prefix'. Please try again."
    exit 1
fi

# Get the first word of the input file name for output file naming
base_name=$(basename "$input_file")
output_file="${base_name%% *} INSCRIBED.mkv"

# Use ffmpeg to overlay text at the halfway position between top and center
ffmpeg -i "$input_file" -vf "drawtext=text='$input_text':x=(w-tw)/2:y=(h/4)/2-10:shadowx=2:shadowy=2:shadowcolor=gray:fontcolor=black:fontsize=32" -c:v libx264 -preset slow -crf 18 -c:a copy "$output_file" -y

echo "Text has been added to the video and saved as $output_file."
