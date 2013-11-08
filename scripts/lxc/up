#!/bin/bash
function start() {
	lxc-start -n "$1" -d
}

function waitForHost() {
    REACHABLE=0

    while [ $REACHABLE -eq 0 ]; do
		ping -q -c 1 "$1" > /dev/null 2> /dev/null

		if [ "$?" -eq 0 ]; then
			REACHABLE=1
		fi
    done
}

# start the containers which don't depend on anything else
echo "Starting containers with no dependencies..."
for c in dns "http-proxy" "https-terminator" mail mysql master; do
	echo -n "	$c..."
	start "$c"
	echo " ok"
done

# start the dependencies
echo "Starting dependencies..."

for c in storage manager; do
	echo -n "	$c..."
	start "$c"
	echo -n " started..."
	waitForHost "$c"
	echo " up!"
done

# start the remaining containers
echo "Starting remaining containers..."
for c in apache "client-shell" sandbox; do
	echo -n "	$c..."
	start "$c"
	echo " ok"
done
