#!/bin/sh

killall picom 2> /dev/null
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
picom --config ${XDG_CONFIG_HOME:-$HOME/.config}/picom/picom.conf --experimental-backends --vsync &

${XDG_CONFIG_HOME:-$HOME/.config}/polybar/launch.sh &

feh --no-fehbg --randomize --bg-scale $HOME/Pictures/Wallpapers/* &

clipmenud &

dunst &

autotiling &

setxkbmap -option ctrl:nocaps &

xset r rate 300 50 &

sxhkd -c ${XDG_CONFIG_HOME:-$HOME/.config}/sxhkd/sxhkdrc &
