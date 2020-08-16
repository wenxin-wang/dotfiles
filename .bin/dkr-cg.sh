#!/bin/bash
set -e

ID=$(/usr/bin/docker "$@")
PID=$(docker inspect -f '{{.State.Pid}}' $ID)

declare -A SRC DEST

for line in $(grep 'name=' /proc/$PID/cgroup); do
echo "hi $line"
        IFS=: read _ NAME LOC <<< "$line"
        SRC[${NAME##name=}]=$LOC
done 

for line in $(grep 'name=' /proc/$$/cgroup); do
echo "ho $line"
        IFS=: read _ NAME LOC <<< "$line"
        DEST[${NAME##name=}]=$LOC
done

for type in ${!SRC[@]}; do
echo $type "${SRC[$type]}" "${DEST[$type]}" $(basename "${SRC[$type]}")
        from=/sys/fs/cgroup/${type}${SRC[$type]}
        to=/sys/fs/cgroup/$type/"${DEST[$type]}"/$(basename "${SRC[$type]}")

        echo $from "=>" $to
        mkdir -p $to
        for p in $(<$from/cgroup.procs); do
                echo $p > $to/cgroup.procs
        done
done
