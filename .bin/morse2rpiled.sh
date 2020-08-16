#!/bin/bash

set -e

DIT_TIME=${DIT_TIME:-0.2}
DAH_TIME=${DAH_TIME:-0.6}
LETTER_SLEEP=${LETTER_SLEEP:-0.4}
WORD_SLEEP=${WORD_SLEEP:-0.6}

LED_SYS=/sys/class/leds/led0
TRIGGER_SYS=$LED_SYS/trigger
BRIGHTNESS_SYS=$LED_SYS/brightness

trigger=$(grep -E -o '\[.*\]' $TRIGGER_SYS)
trigger=${trigger:1:-1}

finish() {
    echo "$trigger" >$TRIGGER_SYS
}

trap finish EXIT

led_on() {
    echo 255 >$BRIGHTNESS_SYS
}

led_off() {
    echo 0 >$BRIGHTNESS_SYS
}

dit() {
    led_on
    sleep $DIT_TIME
    led_off
    sleep $DIT_TIME
}

dah() {
    led_on
    sleep $DAH_TIME
    led_off
    sleep $DIT_TIME
}

echo none >$TRIGGER_SYS

while IFS="" read -r -n 1 char; do
    if [ z"$char" == z"." ]; then
        dit
    elif [ z"$char" == z"-" ]; then
        dah
    elif [ z"$char" == z" " ]; then
        sleep $LETTER_SLEEP
    else
        sleep $WORD_SLEEP
    fi
done
