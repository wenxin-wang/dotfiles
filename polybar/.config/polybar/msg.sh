#!/bin/env sh

if [ $# -lt 1 ]; then
        echo usage: $0 name options...
        exit 1
fi

name=$1
shift

RUN_DIR=/var/run/user/$UID/polybar
PID_FILE=$RUN_DIR/$name.pid

mkdir -p $RUN_DIR
touch $PID_FILE

pid=$(cat $PID_FILE)

if [ -n "$pid" ] && kill -0 $pid 2>&1 && ps -p $pid -o comm= | grep -q polybar; then
    polybar-msg -p $pid $@
fi
