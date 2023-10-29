#!/usr/bin/bash

date=$(date +'%y-%m-%d')
folder=$HOME/Pictures/screenshots
sopts="-b 000000BF -c ffffff80"
type="_$1"

if [[ -f $folder/"$date$type.png" ]]; then
    for i in $folder/$date$type*.png; do
        inc=$(($inc+ 1))
    done
    amount="_$inc"
    echo $amount
fi

case "$1" in
    "snip")
        grim -g "$(slurp $sopts)" $folder/"$date$type$amount.png"
        wl-copy -t image/png < $folder/"$date$type$amount.png"
        ;;
    "full")
        mon=$(hyprctl -j activeworkspace | jq -r '.["monitor"]')
        grim -o $mon $folder/"$date$type$amount.png"
esac
