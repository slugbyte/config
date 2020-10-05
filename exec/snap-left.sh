#!/bin/bash
WIDTH=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)
WIDTH=$(calc "int($WIDTH*0.5)-8")
HEIGHT=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)

HEIGHT=$(calc "int($HEIGHT)-8")


wmctrl -r :ACTIVE: -b remove,maximized_horz,sticky
wmctrl -r :ACTIVE: -e "0,0,0,$WIDTH,$HEIGHT"
