#!/usr/bin/env bash

icon="$HOME/Pictures/lock.png"
tmpbg='/tmp/screen.png'

(( $# )) && { icon=$1; }

scrot "$tmpbg"
convert "$tmpbg" -scale 10% -scale 1000% -fill indigo -tint 50 "$tmpbg"
# convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"

i3lock \
    --insidecolor=00000000 \
    --ringcolor=0000003e \
    --linecolor=00000000 \
    --keyhlcolor=ffffff80 \
    --ringvercolor=ffffff00 \
    --separatorcolor=22222260 \
    --insidevercolor=ffffff1c \
    --ringwrongcolor=ffffff55 \
    --insidewrongcolor=ffffff1c \
    -i "$tmpbg"
