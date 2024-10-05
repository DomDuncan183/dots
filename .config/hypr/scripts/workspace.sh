#!/usr/bin/dash

current=$(hyprctl -j monitors | jq -r '.[] | select(.focused == true) | .activeWorkspace.id')
max=10
min=1

case $2 in
"+1")
    if [ "$current" != "$max" ]; then
        num=$((current + 1))
    else
        num=$min
    fi
    ;;
"-1")
    if [ "$current" != "$min" ]; then
        num=$((current - 1))
    else
        num=$max
    fi
    ;;
esac

hyprctl dispatch "$1" "$num" >/dev/null 2>&1
