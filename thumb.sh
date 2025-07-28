#!/bin/bash

# Function to get the image dimensions
get_dimensions() {
ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=p=0:s=x "$1"
}

# Create an empty filter_complex command
filter_complex=""

# Process each image
for i in 0 1 2; do
dims=$(get_dimensions "$((i + 1)).jpg")
width=${dims%x*}
height=${dims#*x}
    
if (( width >= height )); then
# Landscape: crop middle 1/3
filter_complex+="[$i:v]crop=iw/3:ih:iw/3:0[seg$((i + 1))];"
else
# Portrait: use the full image
filter_complex+="[$i:v]scale=iw:ih[seg$((i + 1))];"
fi
done

# Combine the images horizontally
filter_complex+="[seg1][seg2]hstack=inputs=2[part1];[part1][seg3]hstack=inputs=2[output]"

# Run the ffmpeg command
ffmpeg -i 1.jpg -i 2.jpg -i 3.jpg -filter_complex "$filter_complex" -map "[output]" \
       -s 1280x720 "output_$(date +%s).jpg"

