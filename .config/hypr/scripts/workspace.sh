#!/usr/bin/dash

get_new_location() {
    current=$1
    max=$2
    min=$3
    local direction=$4

    location
    case $direction in
    "+1")
        if [ "$current" != "$max" ]; then
            location=$((current + 1))
        else
            location=$min
        fi
        ;;
    "-1")
        if [ "$current" != "$min" ]; then
            location=$((current - 1))
        else
            location=$max
        fi
        ;;
    esac

    echo "$location"
}

main() {
    local dispatcher=$1
    local direction=$2

    location
    currentWorkspaceID
    min_workspace=1
    max_workspace=10

    currentWorkspaceID=$(hyprctl -j monitors | jq -r '.[] | select(.focused == true) | .activeWorkspace.id')
    location=$(get_new_location "$currentWorkspaceID" "$max_workspace" "$min_workspace" "$direction")

    hyprctl dispatch "$dispatcher" "$location" >/dev/null 2>&1
}
main "$@"
