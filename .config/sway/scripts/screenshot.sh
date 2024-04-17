#!/usr/bin/bash

date=$(date +'%y-%m-%d')
screenshotDir=$HOME/Pictures/Screenshots

if ! [[ -d "$screenshotDir/$1/$date" ]]; then
    mkdir "$screenshotDir/$1/$date"
fi

if [[ -f "$screenshotDir/$1/$date/$date.png" ]]; then
    for i in $screenshotDir/$1/$date/$date*.png; do
        inc=$(($inc + 1))
    done
    amount="_$inc"
fi
picturePath="$screenshotDir/$1/$date/$date$amount.png"

case "$1" in
"Region")
    grim -g "$(slurp -b 000000BF -c ffffff80)" $picturePath

    if [[ $? == 0 ]]; then
        wl-copy -t image/png <$picturePath
        notify-send "Screenshot (snip)" "Copied to clipboard and saved as $date$amount.png"
    fi
    ;;
"Window")
    mon=$(swaymsg -rt get_outputs | jq -r '.[] | select(.focused=true) | .name')
    grim -o $mon $picturePath

    if [[ $? == 0 ]]; then
        notify-send "Screenshot (full)" "Saved as $date$amount.png"
    fi
    ;;
esac
