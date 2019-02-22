#!/bin/env sh

if [ $# -ne 1 ]; then
	echo usage: $0 name
	exit 1
fi

name=$1

RUN_DIR=/var/run/user/$UID/polybar
PID_FILE=$RUN_DIR/$name.pid

mkdir -p $RUN_DIR
touch $PID_FILE

pid=$(cat $PID_FILE)

if [ -n "$pid" ] && kill -0 $pid 2>&1 && ps -p $pid -o comm= | grep -q polybar; then
    kill $pid
fi

polybar $name &
echo $! >$PID_FILE
