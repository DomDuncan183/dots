# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# stock config
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
zstyle :compinstall filename '/home/dom/.zshrc'
autoload -Uz compinit
compinit

# fix alt backspace
autoload -U select-word-style
select-word-style bash

case "$TERM" in
"xterm-kitty" | "tmux-256color")
    fastfetch
    eval "$(starship init zsh)"
    source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    ;;
*)
    # PS1="[%n@%m %1~]%(!.#.$) "
    PS1="
%K{cyan}%F{black} 󰣇 %f%k\
%K{blue}%F{cyan}%f%k\
%K{blue}%F{black} %n@%m %f%k\
%K{yellow}%F{blue}%f%k\
%K{yellow}%F{black} %1~ %f%k\
%F{yellow}%f \
%F{red}%(?..✖  )%f\
"
    ;;
esac
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source ~/.config/scripts/fzf.sh
source <(fzf --zsh)
eval "$(zoxide init zsh)"

lfcd() { cd "$(\lf -print-last-dir "$@")" }
bindkey -s '^o' 'lfcd^M'

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
alias sp="sudo pacman"
alias sps="sudo pacman -S"
alias spr="sudo pacman -Rns"
alias spu="sudo pacman -Syu"
alias psi="pacman -Si"
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
# source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
