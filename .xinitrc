#!/bin/bash

# Environments.

if [ -d /etc/X11/xinit/xinitrc.d]; then
  for x in /etc/X11/xinit/xinitrc.d/*; do
    [[ -x $x ]] && . $x
  done
  unset x
fi

if [ -f $HOME/.xsession ]; then
  . $HOME/.xsession
fi

systemctl --user import-environment DISPLAY XAUTHORITY

if command -v dbus-update-activation-environment >/dev/null 2>&1; then
    dbus-update-activation-environment DISPLAY XAUTHORITY
fi

# Start services.

systemctl --user start my-graphical-session.target

qtile start

# Blocked until user exits.

# Cleanning up.

systemctl --user stop my-graphical-session.target
systemctl --user stop my-graphical-session-pre.target

while [ -n "$(systemctl --user --no-legend --state=dactiviting list-units)" ]; do
  sleep 0.5
done
