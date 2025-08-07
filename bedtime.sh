#!/bin/bash

DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus \
notify-send -t 900000 "ATTENTION" "Time for bed UwU"

#crontab -e: 15 23 * * * /home/yourusername/notify.sh
