#!/bin/dash

exec kitty +kitten icat --clear --stdin no --silent --transfer-mode file </dev/null >/dev/tty
