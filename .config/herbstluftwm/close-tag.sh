#!/bin/bash

# Multi monitor support. Needs MONITOR environment variable to be set for each instance of polybar
# If MONITOR environment variable is not set this will default to monitor 0
# Check https://github.com/polybar/polybar/issues/763
MON_IDX="0"
mapfile -t MONITOR_LIST < <(polybar --list-monitors | cut -d":" -f1)
for (( i=0; i<$((${#MONITOR_LIST[@]})); i++ )); do
    [[ ${MONITOR_LIST[${i}]} == "$MONITOR" ]] && MON_IDX="$i"
done;

IFS=$'\t' read -ra tags <<< "$(herbstclient tag_status "${MON_IDX}")"
target_tag=$(for tag_status in "${tags[@]}" ; do
                 # Read the prefix from each tag and render them according to that prefix
                 tag="${tag_status:1}"
                 echo $tag
             done | rofi -show-icons -terminal urxvtc -dmenu -p "hlwm: close tag")

if [ -z "$target_tag" ]; then
    exit 0
fi

herbstclient merge_tag $target_tag inbox
