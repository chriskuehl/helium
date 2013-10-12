#!/bin/sh                                                               
awk -F: '($3>=1000) && ($3!=65534)' /etc/passwd > /srv/users/passwd
awk -F: '($3>=1000) && ($3!=65534)' /etc/group > /srv/users/group
echo -n "" > /srv/users/shadow

awk -F: '{print $1}' /srv/users/passwd | \
while read USER_NAME; do
	echo "$USER_NAME:!::0:99999:7:::" >> /srv/users/shadow
done

echo "All user files generated."
