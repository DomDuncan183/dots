#!/bin/bash

FILES=("$HOME"/.config/wallpapers/*)

getIdx() {
    # randomFile=$(find "$dir" -type f | shuf -n 1)
    # local currentFile
    # currentFile=$(swww query)
    # currentFile="${currentFile##*/}"

    local idx
    idx=$(cat "$1")
    if ((idx > ${#FILES[@]})); then idx=0; fi

    case "$2" in
    next)
        idx=$((idx + 1))
        ;;
    prev)
        idx=$((idx - 1))
        ;;
    esac
    echo "$idx"
}

setPaper() {
    local type="grow"
    local fps="60"
    # local bezier=".43,1.19,1,.4"
    local bezier="1,.04,.58,.92"
    local time="1"
    local pos="1.0,0"
    swww img \
        --transition-type="$type" \
        --transition-pos="$pos" \
        --transition-bezier="$bezier" \
        --transition-fps="$fps" \
        --transition-duration="$time" \
        --transition-step="200" \
        "${FILES[$idx]}"
}

main() {
    local direction=$1
    local idx
    local idxFile="$HOME/.cache/swww/idx"

    idx=$(getIdx "$idxFile" "$direction")
    setPaper "$idx"
    echo "$idx" >"$idxFile"
}
main "$@"
