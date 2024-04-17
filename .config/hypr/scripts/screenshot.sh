#!/usr/bin/bash

date=$(date +'%y-%m-%d')
folder=$HOME/Pictures/Screenshots
sopts="-b 000000BF -c ffffff80"
type="_$1"

if ! [[ -d "$folder/$1/$date" ]]; then
    mkdir "$folder/$1/$date"
fi

if [[ -f "$folder/$1/$date/$date.png" ]]; then
    for i in $folder/$1/$date/$date*.png; do
        inc=$(($inc+ 1))
    done
    amount="_$inc"
    echo $amount
fi

case "$1" in
    "snip")
        grim -g "$(slurp $sopts)" "$folder/$1/$date/$date$amount.png"
        wl-copy -t image/png < "$folder/$1/$date/$date$amount.png"
        if [[ $? == 0 ]]; then
            notify-send "Screenshot (snip)" "Copied to clipboard and saved as $date$amount.png"
        fi
        ;;
    "full")
        mon=$(hyprctl -j activeworkspace | jq -r '.["monitor"]')
        grim -o $mon $folder/"$date$type$amount.png"
        if [[ $? == 0 ]]; then
            notify-send "Screenshot (full)" "Saved as $date$type$amount.png"
        fi
esac
