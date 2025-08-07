#!/bin/bash

day=$(find $HOME/media/wp/day -type f | shuf -n 1) #Finds regular type files piped into shuf selecting 1
selection=$(basename $day)
night=$(find $HOME/media/wp/night/$selection)

cp $day $HOME/.day.png
cp $night $HOME/.night.png
