# -*- mode: Shell-script -*-

set -ex

systemctl --use stop graphical-session.target graphical-session-pre.target

#urxvtd -q -o -f

#xrandr --setprovideroffloadsink radeon Intel

#eval $(gnome-keyring-daemon -d --components=pkcs11,secrets,ssh,gpg)

. ~/.profile

# compton &

# xss-lock -- slock &

# rand_bg
# xkb-custom
# dex -a
