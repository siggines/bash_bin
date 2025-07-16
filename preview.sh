#!/bin/bash

# Prompt user for video file name
read -p "Enter the video file name or starting word: " input

# Find the file
file=$(ls *.mkv 2>/dev/null | grep -i "^$input" | head -n 1)

# Check if file exists
if [ -z "$file" ]; then
    echo "No video file found starting with '$input'."
    exit 1
fi

# Prompt user for timestamp
read -p "Enter the timestamp (format HH:MM:SS): " timestamp

# Validate timestamp format
if [[ ! $timestamp =~ ^[0-9]{2}:[0-9]{2}:[0-9]{2}$ ]]; then
    echo "Invalid timestamp format. Use HH:MM:SS."
    exit 1
fi

# Generate preview file name
preview_file="preview_${file}"

# Extract 5-second clip using ffmpeg
ffmpeg -i "$file" -ss "$timestamp" -t 5 -c:v libx264 -preset slow -crf 18 -c:a copy "$preview_file"

# Check if the operation was successful
if [ $? -eq 0 ]; then
    echo "Preview clip created: $preview_file"
else
    echo "Failed to create preview clip."
fi
