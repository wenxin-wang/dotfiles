#!/bin/bash

set -ex

systemctl --use stop graphical-session.target graphical-session-pre.target

# Environments.

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for x in /etc/X11/xinit/xinitrc.d/*; do
    [[ -x $x ]] && . $x
  done
  unset x
fi

. ~/.profile

if [ -f $HOME/.xsessionrc ]; then
  . $HOME/.xsessionrc
fi

systemctl --user import-environment DISPLAY XAUTHORITY

if command -v dbus-update-activation-environment >/dev/null 2>&1; then
    dbus-update-activation-environment DISPLAY XAUTHORITY
fi

# Start services.

systemctl --user start my-graphical-session.target

# dbus-launch --exit-with-session qtile start
# dbus-launch --exit-with-session i3
dbus-launch --exit-with-session herbstluftwm --locked

# Blocked until user exits.

# Cleanning up.

systemctl --user stop my-graphical-session.target
systemctl --user stop graphical-session-pre.target

while [ -n "$(systemctl --user --no-legend --state=dactiviting list-units)" ]; do
  sleep 0.5
done
