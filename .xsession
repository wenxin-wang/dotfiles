# -*- mode: Shell-script -*-

set -ex
systemctl --use stop graphical-session.target graphical-session-pre.target
. ~/.profile
