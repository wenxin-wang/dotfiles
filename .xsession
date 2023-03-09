# -*- mode: Shell-script -*-
#urxvtd -q -o -f

#xrandr --setprovideroffloadsink radeon Intel

#eval $(gnome-keyring-daemon -d --components=pkcs11,secrets,ssh,gpg)
set -a
. ~/.xsession_env
set +a

. ~/.profile

# compton &

# xss-lock -- slock &

# rand_bg
# xkb-custom
dex -a
