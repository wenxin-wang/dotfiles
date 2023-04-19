#!/bin/bash

set -ex

systemctl --use stop graphical-session.target graphical-session-pre.target

# Environments.

# # Borrowed from /etc/xdg/xfce4/xinitrc.
# 
# # Set DESKTOP_SESSION so that one can detect easily if an Xfce session is running
# if test "x$DESKTOP_SESSION" = "x"; then
#   DESKTOP_SESSION="xfce"
#   export DESKTOP_SESSION
# fi
# 
# if test "x$XDG_CURRENT_DESKTOP" = "x"; then
#   XDG_CURRENT_DESKTOP="XFCE"
#   export XDG_CURRENT_DESKTOP
# fi

cat ~/.Xresources | xrdb -merge -

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

if command -v systemctl >/dev/null 2>&1 && systemctl --user list-jobs >/dev/null 2>&1; then # user session is running
  dbus-update-activation-environment --systemd XAUTHLOCALHOSTNAME=$XAUTHLOCALHOSTNAME
fi

systemctl --user import-environment
systemctl --user start my-graphical-session.target
# dbus-launch --exit-with-session qtile start
# dbus-launch --exit-with-session i3
# dbus-launch --exit-with-session herbstluftwm --locked
herbstluftwm --locked
# xfce4-session

# Blocked until user exits.

# Cleanning up.

systemctl --user stop my-graphical-session.target
systemctl --user stop graphical-session-pre.target

while [ -n "$(systemctl --user --no-legend --state=dactiviting list-units)" ]; do
  sleep 0.5
done
