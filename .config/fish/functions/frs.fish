function frs
    set rg "rg -i -. --line-number --with-filename --no-heading --color=always"
    echo "Recursively search directories for a regex pattern" | fzf --ansi \
        --delimiter ":" \
        --preview "$HOME/.config/scripts/preview.sh rg {1} {2}" \
        --preview-window "+{2}+3/2" \
        --bind "alt-enter:become(lf {1}),enter:become(nvim {1} +{2}),change:reload:$rg {q}"
end
