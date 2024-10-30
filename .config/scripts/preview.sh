#!/opt/homebrew/bin/dash

drawKitty() {
    case "$1" in
    fzf)
        kitty icat --clear --transfer-mode memory --stdin no --silent --place "${w}x${h}@0x0" "$file"
        ;;
    lf)
        kitty +kitten icat --silent --stdin no --transfer-mode file --place "${w}x${h}@${x}x${y+5}" "$file" </dev/null >/dev/tty
        exit 1
        ;;
    esac
}

drawSixel() {
    chafa -f sixel -s "$w"x"$h" --animate off --polite on "$file"
    exit 0
}

checkExtension() {
    if [ -d "$file" ]; then return; fi
    case "$file" in
    *.tar*)
        tar tf "$file"
        ;;
    *.zip)
        unzip -l "$file"
        ;;
    *.rar)
        unrar l "$file"
        ;;
    *.7z)
        7z l "$file"
        ;;
    *.pdf)
        pdftotext "$file" -
        ;;
    *)
        if [ "$program" = "rg" ]; then
            if [ -r "$file" ]; then
                bat --theme Dracula --color always "$file" --highlight-line "$line"
            fi
        else
            bat --theme Dracula --color always "$file"
        fi
        ;;
    esac
}

checkMimeType() {
    local mimeType
    local name

    mimeType=$(file --dereference --brief --mime-type "$file")
    name=$(basename "$file")
    name="${name%.*}"

    case "$mimeType" in
    inode/directory)
        eza --tree --color=always "$file"
        ;;
    image/*)
        drawKitty "$program"
        ;;
    video/*)
        local ffmpeg_cache
        local ffmpeg_thumbnail

        ffmpeg_cache="$HOME/.cache/thumbnails/ffmpeg"
        ffmpeg_thumbnail="$HOME/.cache/thumbnails/ffmpeg/${name%.*}.png"

        if ! [ -d "$ffmpeg_cache" ]; then
            mkdir "$ffmpeg_cache"
        fi
        if ! [ -f "$ffmpeg_thumbnail" ]; then
            ffmpegthumbnailer -i "$file" -s 0 -q 5 -o "$HOME/.cache/thumbnails/ffmpeg/${name%.*}.png"
        fi

        drawKitty "$ffmpeg_thumbnail"
        ;;
    esac
}

main() {
    case "$1" in
    fzf)
        kitty icat --clear --stdin no --silent --transfer-mode memory

        local program="$1"
        local file=$2
        local w=78
        local h=78

        checkExtension 
        checkMimeType
        ;;
    rg)
        local program="$1"
        local file=$2
        local line=$3

        checkExtension
        ;;
    lf)
        local program="$1"
        local file=$2
        local w=$3
        local h=$4
        local x=$5
        local y=$6

        checkExtension
        checkMimeType
        ;;
    esac
}
main "$@"
