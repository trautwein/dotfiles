#!/bin/sh

killall -q polybar

while pgrep -u $UID -x polybar > /dev/null; do sleep 0.1; done

primary_monitor=$(xrandr --query | grep " connected primary" | cut -d" " -f1)

for monitor in $(polybar --list-monitors | cut -d":" -f1); do
    export MONITOR=$monitor
    export TRAY_POSITION=none

    if [[ $monitor == $primary_monitor ]]; then
	    TRAY_POSITION=left
    fi

    polybar --reload default &
done
