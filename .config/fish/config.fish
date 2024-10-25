function starship_transient_prompt_func
    starship module character
end

function init_prompt
    starship init fish | source
    zoxide init --cmd cd fish | source

    enable_transience
    fastfetch --colors-block-range-start 9 --colors-block-width 3
end

if status is-interactive
    set -U fish_greeting
    switch $TERM
        case xterm-kitty
            init_prompt
        case tmux-256color
            init_prompt
    end

    bind \co 'set old_tty (stty -g); stty sane; lfcd; stty $old_tty; commandline -f repaint'
end
