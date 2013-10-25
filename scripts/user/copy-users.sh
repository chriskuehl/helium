#!/bin/sh
for HOST in "sandbox" "apache" "client-shell" "storage"; do
	echo "Copying to $HOST..."
	scp -r /srv/users/* "root@$HOST":/srv/users/
	scp /srv/scripts/srv-update-users.sh "root@$HOST":/srv/scripts/
	ssh "root@$HOST" "/srv/scripts/srv-update-users.sh"
done
