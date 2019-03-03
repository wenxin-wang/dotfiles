#!/bin/env sh

__DIR__=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)

if [ $# -ne 1 ]; then
	echo usage: $0 name
	exit 1
fi

name=$1

$__DIR__/bar.sh $name
sleep 0.5
$__DIR__/msg.sh $name cmd hide
