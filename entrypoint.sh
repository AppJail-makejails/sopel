#!/bin/sh

. /lib.subr

set -e

create_user
change_owner /usr/local/etc/sopel
change_owner /var/log/sopel
change_owner /var/db/sopel
change_owner /var/run/sopel

if [ "${1#-}" != "$1" ]; then
    set -- sopel "$@"
fi

if [ "$1" = "sopel" ]; then
    set -- su-exec noroot "$@"
fi

exec "$@"
