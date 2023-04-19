#!/usr/bin/env bash

# Multi monitor support. Needs MONITOR environment variable to be set for each instance of polybar
# If MONITOR environment variable is not set this will default to monitor 0
# Check https://github.com/polybar/polybar/issues/763
MON_IDX="0"
mapfile -t MONITOR_LIST < <(polybar --list-monitors | cut -d":" -f1)
for (( i=0; i<$((${#MONITOR_LIST[@]})); i++ )); do
  [[ ${MONITOR_LIST[${i}]} == "$MONITOR" ]] && MON_IDX="$i"
done;

herbstclient --idle "tag_*" 2>/dev/null | {

    while true; do
        # Read tags into $tags as array
        IFS=$'\t' read -ra tags <<< "$(herbstclient tag_status "${MON_IDX}")"
        {
            c=1
            for i in "${tags[@]}" ; do
                # Read the prefix from each tag and render them according to that prefix
                case ${i:0:1} in
                    '.')
                        # the tag is empty
                        # TODO Add your formatting tags
                        echo %{B#cecece}
                        ;;
                    ':')
                        # the tag is not empty
                        # TODO Add your formatting tags
                        echo %{B#ffffff}
                        ;;
                    '+')
                        # the tag is viewed on the specified MONITOR, but this monitor is not focused.
                        # TODO Add your formatting tags
                        echo %{B#ffffff}%{u#330000}%{+u}
                        ;;
                    '#')
                        # the tag is viewed on the specified MONITOR and it is focused.
                        # TODO Add your formatting tags
                        echo %{F#6666dd}%{B#ffffff}%{u#7777dd}%{+u}
                        ;;
                    '-')
                        # the tag is viewed on a different MONITOR, but this monitor is not focused.
                        # TODO Add your formatting tags
                        echo %{B#ffffff}%{u#003300}%{+u}
                        ;;
                    '%')
                        # the tag is viewed on a different MONITOR and it is focused.
                        # TODO Add your formatting tags
                        echo %{B#ffffff}%{u#006600}%{+u}
                        ;;
                    '!')
                        # the tag contains an urgent window
                        # TODO Add your formatting tags
                        echo %{B#ffffff}%{u#ce0000}%{+u}
                        ;;
                esac

                # focus the monitor of the current bar before switching tags
                # echo "%{A1:herbstclient focus_monitor ${MON_IDX}; herbstclient use ${i:1}:}  %{F#cccccc}${c}:%{F-}${i:1}  %{A -u -o F- B-}"
                echo "%{A1:herbstclient focus_monitor ${MON_IDX}; herbstclient use ${i:1}:}  ${c}:${i:1}  %{A -u -o F- B-}"
                c=$((c+1))
            done

            # reset foreground and background color to default
            echo "%{F-}%{B-}"
        } | tr -d "\n"

    echo

    # wait for next event from herbstclient --idle
    read -r || break
done
} 2>/dev/null
