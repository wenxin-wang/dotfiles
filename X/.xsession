# -*- mode: Shell-script -*-
#urxvtd -q -o -f

#xrandr --setprovideroffloadsink radeon Intel

#eval $(gnome-keyring-daemon -d --components=pkcs11,secrets,ssh,gpg)
#export GNOME_KEYRING_CONTROL='false' # just a nonsense/invalid value
#export SSH_AUTH_SOCK
export SSH_AUTH_SOCK=/run/user/$UID/keyring/ssh
#export GPG_AGENT_INFO

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export LC_CTYPE="zh_CN.utf8"

# rand_bg
xkb-custom
dex -a
