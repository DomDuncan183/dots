# stock config
HISTFILE=~/.config/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
zstyle :compinstall filename '/home/dom/.zshrc'
autoload -Uz compinit
compinit

# fix alt backspace
autoload -U select-word-style
select-word-style bash

if [[ $TERM == "xterm-kitty" || $TERM == "tmux-256color" ]]; then 
    fastfetch
    eval "$(starship init zsh)"
    source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    PS1="[%n@%m %1~]%(!.#.$) "
fi

# lf
lfcd() { cd "$(\lf -print-last-dir "$@")" }
spinstall() { sudo pacman -S $(pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse) }
bindkey -s '^o' 'lfcd^M'
bindkey -s '^v' 'nvim^M'

alias ls="eza -1F --color=always --icons=always"
alias la="eza -1AF --color=always --icons=always"
alias ld="eza -1DF --color=always --icons=always"
alias ll="eza -AlF --git --color=always --icons=always"
alias tree="eza -T"
alias lf="lfcd"
alias nv="nvim"
alias snv="sudo nvim"

# package manager
alias p="pacman"
alias psearch="pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse"
alias sp="sudo pacman"
alias sps="sudo pacman -S"
alias spr="sudo pacman -Rns"
alias spu="sudo pacman -Syu"
alias y="yay"
alias fpu="flatpak update"
alias fpi="flatpak install --app"

# git
alias ga="git add"
alias gb="git branch"
alias gc="git checkout"
alias gcm="git commit"
alias gd="git diff"
alias gl="git log"
alias gp="git push"
alias gr="git rm"
alias gs="git status"
