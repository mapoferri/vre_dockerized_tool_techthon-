#!/bin/bash
set -e

addgroup --gid "$HOST_GID" application
adduser --uid "$HOST_UID" --gid "$HOST_GID" --gecos "" --disabled-password application

### Insert here privileged tasks.
#bindFS
mkdir -p /shared_data/public
mkdir -p /shared_data/userdata

bindfs --force-user=application --force-group=application --create-for-user=1000 --create-for-group=1000 --chown-ignore --chgrp-ignore /shared_data/userdata_tmp /shared_data/userdata
bindfs --force-user=application --force-group=application --create-for-user=1000 --create-for-group=1000 --chown-ignore --chgrp-ignore /shared_data/public_tmp /shared_data/public


#if [[ $# -gt 0 ]]; then
#    exec sudo -H -u application -- "$@"
#else
#    exec sudo -H -u application -- bash
#fi

exec "$@"
