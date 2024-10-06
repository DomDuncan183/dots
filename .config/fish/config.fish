function init_prompt
    function starship_transient_prompt_func
        starship module character
    end


    starship init fish | source
    zoxide init fish | source
    enable_transience
    fastfetch --colors-block-range-start 9 --colors-block-width 3
end

if status is-interactive
    set -U fish_greeting
    switch $TERM
        case xterm-kitty
            init_prompt
    end

    source ~/.config/fish/alias.fish
    bind \co 'set old_tty (stty -g); stty sane; lfcd; stty $old_tty; commandline -f repaint'
end
