#!/usr/bin/bash

getLocation() {
    local current=$1
    local max=$2
    local min=$3
    local direction=$4

    local location
    case $direction in
    next)
        if [[ $current == $max ]]; then
            location=$min
        else
            location=$((current + 1))
        fi
        ;;
    prev)
        if [[ $current == $min ]]; then
            location=$max
        else
            location=$((current - 1))
        fi
        ;;
    esac

    echo $location
}

main() {
    local dispatcher=$1
    local option=$2
    local direction=$3

    local selectedMonitor=$(hyprctl -j monitors | jq -r '.[] | select(.focused == true)')

    local maxWorkspace
    local minWorkspace
    local monitorID=$(echo $selectedMonitor | jq -r '.id')

    case $monitorID in
    0)
        maxWorkspace=10
        minWorkspace=1
        ;;
    1)
        maxWorkspace=20
        minWorkspace=11
        ;;
    esac

    echo $maxWorkspace
    echo $minWorkspace

    local location
    case $option in
    selectWorkspace)
        location=$direction
        ;;
    moveToMonitor)
        location="mon:$(getLocation $monitorID 1 0 $direction)"
        ;;
    incrementWorkspace)
        local currentWorkspaceID=$(echo $selectedMonitor | jq -r '.activeWorkspace.id')
        location=$(getLocation $currentWorkspaceID $maxWorkspace $minWorkspace $direction)
        ;;
    esac

    hyprctl dispatch $dispatcher $location &>/dev/null
}

main $@
