#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use
#polybar-msg cmd quit
# Otherwise you can use the nuclear option:
killall -q polybar 2>/dev/null

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

THEME="chnvok"
CONFIG_DIR="$HOME/.config/polybar/themes/$THEME/config.ini"

if type "xrandr" >/dev/null; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		MONITOR=$m polybar --reload main -c ""$CONFIG_DIR &
	done
else
	polybar --reload main -c $CONFIG_DIR &
fi
