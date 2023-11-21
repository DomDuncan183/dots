#!/usr/bin/bash

~/.config/feh/fehbg &
pgrep -x polybar > /dev/null || ~/.config/polybar/launch.sh &
pgrep -x picom > /dev/null || picom -b &
pgrep -x sxhkd > /dev/null || sxhkd &
