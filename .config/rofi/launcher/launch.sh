#!/usr/bin/bash

dir="$HOME/.config/rofi/launcher"
theme="launch"

## Run
rofi \
    -show drun \
    -theme ${dir}/${theme}.rasi
