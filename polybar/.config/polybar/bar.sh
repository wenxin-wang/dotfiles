#!/bin/env sh

if [ $# -ne 1 ]; then
	echo usage: $0 barname
	exit 1
fi

barname=$1

RUN_DIR=/var/run/user/$UID/polybar
mkdir -p $RUN_DIR

for pid_file in $RUN_DIR/$barname*.pid; do
    pid=$(cat $pid_file)

    if [ -n "$pid" ] && kill -0 $pid 2>&1 && ps -p $pid -o comm= | grep -q polybar; then
	kill $pid
    fi
    rm $pid_file
done

if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
	pid_file=$RUN_DIR/$barname-$m.pid
	# MONITOR=$m polybar --reload example &
	MONITOR=$m polybar $barname &
	echo $! >$pid_file
    done
else
	pid_file=$RUN_DIR/$barname.pid
	# MONITOR=$m polybar --reload example &
	MONITOR=$m polybar $barname &
	echo $! >$pid_file
fi
