#!/bin/bash

FILES=("$HOME"/.config/wallpapers/*)

getIdx() {
    # randomFile=$(find "$dir" -type f | shuf -n 1)
    # local currentFile
    # currentFile=$(swww query)
    # currentFile="${currentFile##*/}"

    local idx
    idx=$(cat "$1")
    max=$((${#FILES[@]} - 1))

    case "$2" in
    next)
        idx=$((idx + 1))
        ;;
    prev)
        idx=$((idx - 1))
        ;;
    esac

    if ((idx > max)); then
        idx=0
    fi
    if ((idx < 0)); then
        idx=$max
    fi

    echo "$idx"
}

setPaper() {
    local file="${FILES[$idx]}"
    local cache="$HOME/.cache/swww/current"

    local type="grow"
    local fps="60"
    local bezier="1,.02,.80,.25"
    local time=1
    local pos="1.0,0"
    local step=1
    swww img \
        --transition-type="$type" \
        --transition-pos="$pos" \
        --transition-bezier="$bezier" \
        --transition-fps="$fps" \
        --transition-duration="$time" \
        --transition-step="$step" \
        "$file"

    ln -sf "$file" "$cache"
}

main() {
    local direction=$1
    local idx
    local idxFile="$HOME/.cache/swww/idx"

    if ! [[ -r "$idxFile" ]]; then
        echo 0 >"$idxFile"
    fi

    idx=$(getIdx "$idxFile" "$direction")
    setPaper "$idx"
    echo "$idx" >"$idxFile"
}
main "$@"
