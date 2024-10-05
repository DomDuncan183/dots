#!/usr/bin/dash

main() {
    local date
    local fileNum
    local picturePath

    local type=$1
    local dir="$HOME/Pictures/Screenshots/$type"
    date=$(date +'%y-%m-%d')

    if ! [ -d "$dir" ]; then
        mkdir -p "$dir"
    fi

    if [ -f "$dir/$date.png" ]; then
        fileNum="_$(find "$dir" -name "$date*.png" | wc -l)"
    fi
    picturePath="$dir/$date$fileNum.png"

    case "$type" in
    "Snip")
        if grim -g "$(slurp -b 000000BF -c FFFFFF80)" "$picturePath"; then
            wl-copy -t image/png <"$picturePath"
            notify-send "Screenshot (snip)" "Saved as $date$fileNum.png"
        fi
        ;;
    "Monitor")
        monitor=$(hyprctl -j activeworkspace | jq -r '.["monitor"]')

        if grim -o "$monitor" "$picturePath"; then
            notify-send "Screenshot (monitor)" "Saved as $date$fileNum.png"
        fi
        ;;
    esac
}
main "$@"
