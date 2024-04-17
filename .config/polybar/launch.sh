#!/usr/bin/bash

polybar-msg cmd quit

echo "---" | tee -a /tmp/polybar1.log
polybar mybar 2>&1 | tee -a /tmp/polybar1.log & disown
