#!/bin/bash

if [ -f $HOME/.xsession ]; then
  . $HOME/.xsession
fi

systemctl --user start my-graphical-session.target

qtile start

systemctl --user stop my-graphical-session.target
systemctl --user stop my-graphical-session-pre.target

while [ -n "$(systemctl --user --no-legend --state=dactiviting list-units)" ]; do
  sleep 0.5
done
