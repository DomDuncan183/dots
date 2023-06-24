#!/bin/sh

xsetroot -cursor_name left_ptr
~/.config/feh/fehbg.sh &
pgrep -x polkitd > /dev/null || /usr/libexec/polkit-gnome-authentication-agent-1 &
pgrep -x sxhkd > /dev/null || sxhkd &
pgrep -x picom > /dev/null || picom -b &
pgrep -x pipewire > /dev/null || pipewire &

#while ! pgrep -x pipewire > /dev/null; do sleep .01; done
#pgrep -x pipewire-pulse > /dev/null || pipewire-pulse &
#pgrep -x wireplumber > /dev/null || wireplumber &

pgrep -x polybar > /dev/null || ~/.config/polybar/launch.sh &
