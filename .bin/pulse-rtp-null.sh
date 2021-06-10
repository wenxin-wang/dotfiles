#/bin/sh
pactl unload-module module-null-sink
pactl unload-module module-rtp-send
if [ $# -ne 0 ]; then
    exit 0
fi
pactl load-module module-null-sink sink_name=rtp rate=48000
pactl load-module module-rtp-send source=rtp.monitor destination=224.0.0.56 port=4010 mtu=320 format=s16be channels=1
# pactl load-module module-rtp-send source=rtp.monitor destination=192.168.3.4 port=4010 mtu=320
