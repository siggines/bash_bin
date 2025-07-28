#!/bin/bash
shuf -e *.flac | while read -r file; do
mpv --loop-file=0 -- "$file" &
mpv_pid=$!
sleep 1.5
win_id=$(wmctrl -lp | grep "$mpv_pid" | awk '{print $1}')
if [ -n "$win_id" ]; then
wmctrl -ir "$win_id" -t 1
fi
wait $mpv_pid
done
