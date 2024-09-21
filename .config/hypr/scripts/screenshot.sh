#!/usr/bin/bash

date=$(date +'%y-%m-%d')
folder=$HOME/Pictures/Screenshots
type="_$1"

if ! [[ -d "$folder/$1/$date" ]]; then
    mkdir "$folder/$1/$date"
fi

if [[ -f "$folder/$1/$date/$date.png" ]]; then
    fileNameList=("$screenshotDir/$1/$date*.png")
    fileNum="_${#fileNameList[@]}"
fi

case "$1" in
"snip")
    grim -g "$(slurp "-b 000000BF -c ffffff80")" "$folder/$1/$date/$date$fileNum.png"

    if wl-copy -t image/png <"$folder/$1/$date/$date$fileNum.png"; then
        notify-send "Screenshot (snip)" "Copied to clipboard and saved as $date$fileNum.png"
    fi
    ;;
"full")
    mon=$(hyprctl -j activeworkspace | jq -r '.["monitor"]')

    if grim -o "$mon" "$folder/$date$type$fileNum.png"; then
        notify-send "Screenshot (full)" "Saved as $date$type$fileNum.png"
    fi
    ;;
esac
