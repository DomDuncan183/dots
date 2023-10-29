# stock config
HISTFILE=~/.config/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
zstyle :compinstall filename '/home/dom/.zshrc'
autoload -Uz compinit
compinit
autoload -U select-word-style
select-word-style bash
#WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# plugins
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# starship
eval "$(starship init zsh)"
pfetch

# lf
lfcd () { cd "$(command lf -print-last-dir "$@")" }
bindkey -s '^o' 'lfcd\n'

# aliases
alias l="command ls -1F --color=always"
alias ls="command ls -1AF --color=always"
alias ll="command ls -AFhl --color=always"
alias lf="lfcd"
alias nv="nvim"
alias snv="sudo nvim"
alias pac="pacman"
alias spac="sudo pacman"
alias y="yay"
alias ht="htop"
