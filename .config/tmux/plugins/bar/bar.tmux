#!/usr/bin/bash

cmd=()
set() { cmd+=(set -gq "$1" "$2" ";"); }
setw() { cmd+=(set -wgq "$1" "$2" ";"); }

getOption() {
    value=$(tmux show -gqv "$1")
    if [[ -n $value ]]; then
        echo "$value"
    fi
}

buildWindow() {
    local color1=$1
    local color2=$2
    local text="#[fg=white,bg=$color1]$3 "
    local num="#[fg=black,bg=$color2]$4"

    local left1="#[fg=$color1,bg=default]█"
    local left2="#[fg=$color2,bg=$color1]█"
    local right="#[fg=$color2,bg=default]█"

    echo "$left1$text$left2$num$right"
}

buildStatus() {
    local color=$1
    local text="#[fg=black,bg=$color]$2"
    local icon="#[fg=black,bg=$color]$3"

    local left="#[fg=$color,bg=default]█"
    local right="#[fg=$color,bg=default]█"

    echo "$left$icon$text$right"
}

main() {
    set status-style "bg=default, fg=white"
    set mode-style "bg=default"
    set message-style "bg=default"
    set status-left-length "100"
    set status-right-length "100"

    host=$(buildStatus "pink" "#{host_short}" "󰣇  ")
    sessionName=$(buildStatus "#{?client_prefix,red,green}" "#{session_name}" "  ")
    windowName=$(buildStatus "blue" "#{window_name}" "  ")
    time=$(buildStatus "magenta" "%Y-%m-%d %H:%M" "  ")

    set status-left ""
    set status-right "$host$sessionName$windowName$time"

    windowStatus=$(buildWindow "#2e2e38" "blue" "#{pane_current_path}" "#{window_index}")
    setw window-status-format "$windowStatus"
    setw window-status-current-format "$windowStatus"

    tmux "${cmd[@]}"
}
main
