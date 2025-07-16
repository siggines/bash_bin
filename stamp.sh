#!/bin/bash

# Prompt the user for the first word of the file name or 'all'
read -p "Enter file name (fuzzy mode is on), or 'all' to process all videos: " first_word

# If the user wants to process all files, find all video files that do not have 'output' at the start of their names
if [[ "$first_word" =~ ^[Aa]ll$ ]] || [[ "$first_word" == "*" ]]; then
    mapfile -t matches < <(find . -maxdepth 1 -type f -name "*.mkv" ! -name "output*" -print0 | xargs -0 -n1)
else
    # Find files starting with the first word
    mapfile -t matches < <(find . -maxdepth 1 -type f -name "${first_word}*" -print0 | xargs -0 -n1)
fi

# Check how many files matched
if [ ${#matches[@]} -eq 0 ]; then
    echo "No files found starting with '${first_word}'."
    exit 1
elif [ ${#matches[@]} -gt 1 ]; then
    echo "Multiple files found starting with '${first_word}':"
    for file in "${matches[@]}"; do
        echo " - ${file#./}"
    done
    echo "Please specify more of the file name to narrow it down."
    exit 1
fi

# Ask the user where to place the stamp image
read -p "Do you want the stamp in the bottom left or bottom right? (right/left): " position
position="${position,,}"  # Convert to lowercase

# Check for valid input
if [[ "$position" != "left" && "$position" != "right" ]]; then
    echo "Invalid input. Please enter 'left' or 'right'."
    exit 1
fi

# Ask if the user wants the dark grey box
read -p "Do you need a box in the top left or top right? (yes/no): " box_answer
box_answer="${box_answer,,}"

if [[ "$box_answer" == "yes" ]]; then
    read -p "Do you want the box in the top left or top right? (left/right): " box_position
    box_position="${box_position,,}"
    if [[ "$box_position" != "left" && "$box_position" != "right" ]]; then
        echo "Invalid input. Please enter 'left' or 'right'."
        exit 1
    fi
fi

# Use the single match
input_file="${matches[0]#./}"
output_file="output_${input_file%.*}.mkv"

# Set overlay position for the stamp
if [[ "$position" == "right" ]]; then
    stamp_overlay="W-w-10:H-h-10"
else
    stamp_overlay="10:H-h-10"
fi

# Set overlay position and size for the box
box_overlay=""
if [[ "$box_answer" == "yes" ]]; then
    if [[ "$box_position" == "right" ]]; then
        box_overlay="drawbox=x=W-110:y=0:w=60:h=60:color=#333333@1:t=fill"
    else
        box_overlay="drawbox=x=0:y=0:w=60:h=60:color=#333333@1:t=fill"
    fi
fi

# Combine filters for both stamp and box
if [[ -n "$box_overlay" ]]; then
    filter_complex="[1:v]scale=225:114,drawbox=t=3:w=230:h=120:x=0:y=0:color=#444444@1[stamp_with_border];[0:v][stamp_with_border]overlay=$stamp_overlay,$box_overlay"
else
    filter_complex="[1:v]scale=225:114,drawbox=t=3:w=230:h=120:x=0:y=0:color=#444444@1[stamp_with_border];[0:v][stamp_with_border]overlay=$stamp_overlay"
fi

# Run FFmpeg command
ffmpeg -i "$input_file" -i stamp.png -filter_complex "$filter_complex" \
-c:v libx264 -preset slow -crf 16 -c:a copy -pix_fmt yuv420p "$output_file"

echo "Processing completed. Output saved as $output_file."
