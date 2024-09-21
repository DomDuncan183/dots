HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
zstyle :compinstall filename '/home/dom/.zshrc'
autoload -Uz compinit
compinit
autoload -U select-word-style
select-word-style bash

case "$TERM" in
"xterm-kitty" | "tmux-256color")
    fastfetch
    eval "$(starship init zsh)"
    source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    ;;
*)
    PS1="[%n@%m %1~]%(!.#.$) "
#     PS1="
# %K{cyan}%F{black} 󰣇 %f%k\
# %K{blue}%F{cyan}%f%k\
# %K{blue}%F{black} %n@%m %f%k\
# %K{yellow}%F{blue}%f%k\
# %K{yellow}%F{black} %1~ %f%k\
# %F{yellow}%f \
# %F{red}%(?..✖  )%f\
# "
    ;;
esac
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source ~/.config/scripts/fzf.sh
source <(fzf --zsh)
eval "$(zoxide init zsh)"

lfcd() { z "$(\lf -print-last-dir "$@")" }
cdls() { z "$@" && eza -1AF --color=always --icons=always; }
mkday() {
    name=$(date +'%Y-%m-%d')
    mkdir $name
    cd $name
}
bindkey -s '^o' 'lfcd^M'

alias ls="eza -1F --color=always --icons=always"
alias la="eza -1AF --color=always --icons=always"
alias ld="eza -1DF --color=always --icons=always"
alias ll="eza -AlF --git --color=always --icons=always"
alias tree="eza -T"
alias cd="cdls"
alias lf="lfcd"
alias nv="nvim"
alias dnv="doas nvim"

alias p="pacman"
alias dp="doas pacman"
alias dps="doas pacman -S"
alias dpr="doas pacman -Rns"
alias dpu="doas pacman -Syu"
alias apu="doas pacman -Syu && flatpak update"
alias psi="pacman -Si"
alias y="yay"
alias fpu="flatpak update"
alias fpi="flatpak install --app"

alias ga="git add"
alias gb="git branch"
alias gc="git checkout"
alias gcm="git commit -m"
alias gd="git diff"
alias gl="git log"
alias gp="git push"
alias gr="git rm"
alias gs="git status"
