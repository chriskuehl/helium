#!/bin/sh
./running.sh |
while read HOST; do
	echo "$HOST:"
	0</dev/null ssh "root@$HOST" "$@"
done
