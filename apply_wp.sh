#!/bin/bash
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus


if [ -z "$1" ]; then
    echo "Error: No wallpaper file provided."
    exit 1
fi

WALLPAPER="$1"

if [ ! -f "$WALLPAPER" ]; then
    echo "Error: File not found: $WALLPAPER"
    exit 1
fi

# Set wallpaper image
for prop in $(xfconf-query -c xfce4-desktop -l | grep last-image); do
    xfconf-query -c xfce4-desktop -p "$prop" -s "$WALLPAPER"
done

# Set wallpaper style to scaled (3)
for prop in $(xfconf-query -c xfce4-desktop -l | grep image-style); do
    xfconf-query -c xfce4-desktop -p "$prop" -s 3
done

xfdesktop --reload
