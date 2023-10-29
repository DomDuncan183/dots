#!/usr/bin/bash

current=$(hyprctl -j activeworkspace | jq -r '.["id"]')

case $1 in
    "next")
        if [[ $current == 10 ]]; then
            hyprctl dispatch workspace 1
        else
            hyprctl dispatch workspace $(( current + 1 ))
        fi
        ;;
    "prev")
        if [[ $current == 1 ]]; then
            hyprctl dispatch workspace 10
        else
            hyprctl dispatch workspace $(( current - 1 ))
        fi
esac
