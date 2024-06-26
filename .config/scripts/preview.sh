#!/bin/bash

width=50
height=50

program=$1
file=$2

if ! [[ -z ${3+x} && -z ${4+x} ]]; then
    width=$3
    height=$4
fi

if [[ $program == "fzf" && -d "$file" ]]; then
    eza --tree --color=always "$file" | head -200
    exit 0
fi

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
*.jpg | *.jpeg | *.png)
    chafa -f sixel -s "$width"x"$height" --animate off --polite on "$file"
    ;;
*.avi | *.gif | *.mp4 | *.mkv | *.webm)
    ffmpeg_cache="$HOME/.cache/thumbnails/ffmpeg"
    # sixel_cache="$HOME/.cache/thumbnails/sixel"

    name=$(basename "$file")
    name="${name%.*}"

    ffmpeg_thumbnail="$HOME/.cache/thumbnails/ffmpeg/${name%.*}.png"
    # sixel_img="$HOME/.cache/thumbnails/sixel/${name%.*}.sixel"

    if ! [[ -d $ffmpeg_cache ]]; then
        mkdir "$ffmpeg_cache"
    fi
    # if ! [[ -d $sixel_cache ]]; then
    #     mkdir "$sixel_cache"
    # fi
    if ! [[ -f $ffmpeg_thumbnail ]]; then
        ffmpegthumbnailer -i "$file" -s 0 -q 5 -o "$HOME/.cache/thumbnails/ffmpeg/${name%.*}.png"
    fi
    # if ! [[ -f $sixel_img ]]; then
    #     img2sixel -w "$width" -h "$height" "$ffmpeg_thumbnail" -o "$sixel_img"
    # fi

    # chafa -f sixel -s "$widthx$height" --animate off --polite on "$sixel_img"
    chafa -f sixel -s "$width"x"$height" --animate off --polite on "$ffmpeg_thumbnail"
    # cat "$sixel_img"
    ;;
*)
    bat --color always "$file"
    ;;
esac
