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

# plugins
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# starship
eval "$(starship init zsh)"

# lf
lfcd () { cd "$(command lf -print-last-dir "$@")" }
bindkey -s '^o' 'lfcd\n'

# aliases
alias btry="cat /sys/class/power_supply/BAT0/capacity"

alias ls="command eza -1F --color=always --icons=always"
alias la="command eza -1AF --color=always --icons=always"
alias ll="command eza -AFhl --color=always --icons=always"
alias lf="lfcd"
alias nv="nvim"
alias snv="sudo nvim"

# package managers
alias p="pacman"
alias psearch="pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse"
alias sp="sudo pacman"
alias sps="sudo pacman -S"
alias spr="sudo pacman -Rns"
alias spu="sudo pacman -Syu"
alias y="yay"
alias fpi="flatpak install --app"


# git
alias ga="git add"
alias gb="git branch"
alias gc="git checkout"
alias gcmt="git commit"
alias gd="git diff"
alias gl="git log"
alias gp="git push"
alias gr="git rm"
alias gs="git status"
