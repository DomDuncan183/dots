function pf 
    pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse \
        --bind 'enter:become(doas pacman -S {}),alt-enter:accept'
end
