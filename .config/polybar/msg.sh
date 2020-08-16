#!/bin/env sh

if [ $# -lt 1 ]; then
        echo usage: $0 barname options...
        exit 1
fi

barname=$1
shift

RUN_DIR=/var/run/user/$UID/polybar
mkdir -p $RUN_DIR

for pid_file in $RUN_DIR/$barname*.pid; do
    pid=$(cat $pid_file)

    if [ -n "$pid" ] && kill -0 $pid 2>&1 && ps -p $pid -o comm= | grep -q polybar; then
	polybar-msg -p $pid $@
    fi
done
