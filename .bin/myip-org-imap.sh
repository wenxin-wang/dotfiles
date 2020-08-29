#!/bin/sh
/bin/echo "* $(
/home/wenxin/02Projects/network/p2p/stunserver/stunclient 154.8.238.46 41114 | tail -n1 | cut -d' ' -f3;
/home/wenxin/02Projects/network/p2p/stunserver/stunclient --family 6 2402:4e00:1200:1802:0:90f3:d0a0:5e3a 61114 | tail -n1 | cut -d' ' -f3
)" >/tmp/ip.org && /home/wenxin/.bin/org-imap.sh /tmp/ip.org
