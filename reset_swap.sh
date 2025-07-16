#!/bin/bash

# Disable or enable swap based on argument
if [ "$1" == "off" ]; then
    /sbin/swapoff -a
elif [ "$1" == "on" ]; then
    /sbin/swapon -a
else
    echo "Usage: $0 {on|off}"
    exit 1
fi
