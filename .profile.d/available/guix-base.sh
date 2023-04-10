export GUIX_PROFILE="$HOME/.guix-extra-profiles/base/base"
. "$GUIX_PROFILE/etc/profile"

export GUIX_LOCPATH="$GUIX_PROFILE/lib/locale"

export SSL_CERT_DIR="$GUIX_PROFILE/etc/ssl/certs"
export SSL_CERT_FILE="$GUIX_PROFILE/etc/ssl/certs/ca-certificates.crt"
export GIT_SSL_CAINFO="$SSL_CERT_FILE"

export XDG_DATA_DIRS=$HOME/.guix-extra-profiles/base/base/share:$XDG_DATA_DIRS
