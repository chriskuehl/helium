#!/bin/sh
UNAME="$1"

adduser --shell /usr/bin/zsh --disabled-password --gecos "" "$1"
/srv/scripts/update-users.sh

chown -R "$1:$1" "/home/$1"
chmod 700 "/home/$1"
