zstyle :compinstall filename "$HOME/.config/zsh/.zshrc"

HISTFILE="$HOME/.config/zsh/.histfile"
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

autoload -Uz compinit
compinit
autoload -U select-word-style
select-word-style bash

dir="$HOME/.config/zsh"
case "$TERM" in
"xterm-kitty" | "tmux-256color")
    source <(starship init zsh)
    source <(fzf --zsh)
    source <(zoxide init zsh)

    fastfetch --colors-block-range-start 9 --colors-block-width 3
    source "$dir/zsh-autosuggestions/zsh-autosuggestions.zsh"
    source "$dir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    source "$dir/alias.zsh"
    source "$dir/functions.zsh"
    source "$dir/fzf.zsh"
    ;;
*)
    PS1="[%n@%m %1~]%(!.#.$) "
    ;;
esac

bindkey -s '^o' 'lfcd^M'
