#!/bin/bash

time_in_ms=10000 # total time to darken screen
time_bevore_darken=4000
xbacklight_steps=50
darken_factor=10 # in percent how dark the screen will be


while :
do
    # when time difference is reached (start darken the screen)
    if [[ $(xprintidle) -gt  $(($time_in_ms - $time_bevore_darken)) ]]; then
        echo "Darken Screen now"
        old=$(xbacklight -get)
        xbacklight -time $time_bevore_darken -steps $xbacklight_steps -set $darken_factor
    fi

    # when max idle time reached
    if [[ $(xprintidle) -gt $time_in_ms ]]; then
        xbacklight -time 0 -set $old
        echo "Starting physlock"
        exec physlock -p "Screensaver!"
    fi
done
