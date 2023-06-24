pfetch

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE=~/.config/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
zstyle :compinstall filename '/home/dom/.zshrc'
autoload -Uz compinit
compinit

source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/shell-mommy.zsh
source ~/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme

#eval "$(starship init zsh)"

precmd() { eval "mommy \\$\\(exit \$?\\)" }

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias l='ls'
alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -alh --color=auto'
alias xi='doas xbps-install'
alias xr='doas xbps-remove'
alias xq='xbps-query'
alias ds='doas'
alias n='nvim'
alias dsn='doas nvim'

bindkey '^[[Z'	end-of-line
bindkey '^[h'	backward-char
bindkey '^[l'	forward-char
bindkey '^[k'	up-line-or-history
bindkey '^[j'	down-line-or-history
bindkey '^[^h'	backward-word
bindkey '^[^l'	forward-word
