#!/usr/bin/bash

dpy=$(xrandr -q | grep '.*' | awk '{print $1}')
x=$(cut -d 'x' -f1 <<< "$dpy")
y=$(cut -d 'x' -f2 <<< "$dpy")

locx=$((( x-1280 )/ 2))
locy=$((( y-720 )/ 2))

app=$1
class=${1^}

bspc rule -a "$class" -o state=floating rectangle=1280x720+$locx+$locy && $app
