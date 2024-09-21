#!/usr/bin/dash

current=$(swaymsg -rt get_workspaces | jq -r '.[] | select(.focused) | .num')
view="workspace"
move="move container to workspace"

case $1 in
prev)
    if [ "$current" != 1 ]; then
        num=$((current - 1))
    else
        num=10
    fi
    ;;
next)
    if [ "$current" != 10 ]; then
        num=$((current + 1))
    else
        num=1
    fi
    ;;
esac

case $2 in
both)
    swaymsg "$move" number "$num", $view number "$num"
    ;;
move)
    swaymsg "$move" number "$num"
    ;;
view)
    swaymsg "$view" number "$num"
    ;;
esac
