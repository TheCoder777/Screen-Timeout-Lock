#!/bin/bash


# MIT License

# Copyright (c) 2019 TheCoder777

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


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
