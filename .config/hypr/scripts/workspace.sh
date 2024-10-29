#!/usr/bin/bash

get_location() {
    local option=$1

    if [[ "$monitor_model" != "\"0x0BCA\"" ]] &&
        [[ "$monitor_model" != "\"VG248\"" ]]; then

        min=$(((max + 1) * monitor_id))
        max=$((min + 9))
    fi

    case $option in
    "+1")
        if (( current_workspace != max )); then
            num=$((current_workspace + 1))
        else
            num=$min
        fi
        ;;
    "-1")
        if (( current_workspace != min )); then
            num=$((current_workspace - 1))
        else
            num=$max
        fi
        ;;
    [1-9] | 10)
        if (( min == 1 )); then
            num=$option
        else
            num=$((min + option - 1))
            echo $num
        fi
        ;;
    esac
}

main() {
    local max=10
    local min=1
    local num=0

    local monitor_info
    local monitor_id
    local monitor_model
    local current_workspace

    monitor_info=$(hyprctl -j monitors | jq -r '.[] | select(.focused == true) | [ .id, .model, .activeWorkspace.id ] | @csv')
    IFS=',' read -r monitor_id monitor_model current_workspace <<<"$monitor_info"

    # using dash
    # monitor_id=$(echo "$monitor_info" | sed -n '1p')
    # monitor_model=$(echo "$monitor_info" | sed -n '2p')
    # current_workspace=$(echo "$monitor_info" | sed -n '3p')

    get_location "$2"
    hyprctl dispatch "$1" "$num" >/dev/null 2>&1
}
main "$@"
