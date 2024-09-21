#!/bin/bash

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '$HOME/.config/scripts/preview.sh fzf {}' --preview-window=right,50% --height 100%"

export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_ALT_C_OPTS="--preview '$HOME/.config/scripts/preview.sh fzf {}'"

_fzf_compgen_path() { fd --hidden --exclude .git . "$1"; }
_fzf_compgen_dir() { fd --type=d --hidden --exclude .git . "$1"; }
_fzf_comprun() {
    local command="$1"
    shift

    case "$command" in
    cd) fzf --preview "eza --tree --color=always {} | head -200" "$@" ;;
    export | unset) fzf --preview "eval 'echo \${}'" "$@" ;;
    ssh) fzf --preview "dig {}" "$@" ;;
    *) fzf --preview "$HOME/.config/scripts/preview.sh fzf {}" ;;
    esac
}

frs() {
    rg="rg -. --line-number --with-filename --no-heading --color=always"
    echo "Recursively search directories for a regex pattern" | fzf --ansi \
        --delimiter ":" \
        --preview "$HOME/.config/scripts/preview.sh rg {1} {2}" \
        --preview-window "+{2}+3/2" \
        --bind "alt-enter:become(lf {1}),enter:become(nvim {1} +{2}),change:reload:$rg {q}"
}

pf() { pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse --bind 'enter:become(doas pacman -S {}),alt-enter:accept'; }
