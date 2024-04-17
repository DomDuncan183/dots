#!/usr/bin/bash

local selectedMonitor=$(hyprctl -j monitors | jq -r '.[] | select(.focused == true)')
