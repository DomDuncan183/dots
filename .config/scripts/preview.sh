#!/bin/bash

width=50
height=50

if [[ $1 == "rg" ]]; then
    program="rg"
    file=$2
    line=$3
else
    file=$1
    width=$2
    height=$3
fi

# check file extensions
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
*.txt | *.json)
    args=(--color always "$file")
    if [[ $program == "rg" ]]; then
        args+=(--highlight-line "$line")
    fi

    bat "${args[@]}"
    ;;
*)
    bat --color always "$file"
    ;;
esac

# check mime types
type=$(file --dereference --brief --mime-type "$file")
name=$(basename "$file")
name="${name%.*}"

case "$type" in
inode/directory)
    eza --tree --color=always "$file" | head -200
    ;;
image/*)
    # lf_sixel_cache="$HOME/.cache/thumbnails/lf_sixel_cache"
    # full_name="$lf_sixel_cache/$name.sixel"
    #
    # # echo "$width"
    # # echo "$height"
    #
    # if [[ -f "$full_name" ]]; then
    #     cat "$full_name"
    # else 
    #     # img2sixel "$file" -w "$width" -h "$height" -o "$full_name"
    #     img2sixel "$file" -w 50% -h 50% -o "$full_name"
    #     cat "$full_name"
    # fi

    chafa -f sixel -s "$width"x"$height" --animate off --polite on "$file"
    ;;
video/*)
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
esac
