#!/bin/bash

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '$HOME/.config/scripts/preview.sh fzf {}'"

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
    *) fzf --preview "$HOME/.config/scripts/preview.sh fzf {} 20 20" ;;
    esac
}

frs() {
    local fzf_rg_preview="if [ -d {1} ]; then eza --tree --color=always {1} | head -200; else bat -n --color=always {1} --highlight-line {2}; fi"
    rg -. --line-number --no-heading --color=always "" |
        fzf --ansi \
            --delimiter : \
            --preview "$fzf_rg_preview" \
            --preview-window "+{2}+3/2" \
            --bind "alt-enter:become(lf {1}),enter:become(nvim {1} +{2}),change:reload:rg -. --line-number --no-heading --color=always {q} || true"
}

pf() {
    pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse --bind 'enter:become(sudo pacman -S {}),alt-enter:accept'
}
