#!/bin/sh
DATE=$(date +"%Y-%m-%d-%H-%M-%S")

mkdir -p /etc/passwd.bk
mkdir -p /etc/shadow.bk
mkdir -p /etc/group.bk

cp /etc/passwd "/etc/passwd.bk/passwd-$DATE"
cp /etc/shadow "/etc/shadow.bk/shadow-$DATE"
cp /etc/group "/etc/group.bk/group-$DATE"

# shadow is weird because it doesn't have the user ids
echo -n "" > /etc/shadow.new

cat "/etc/shadow.bk/shadow-$DATE" | \
while read SHADOW_LINE; do
	SHADOW_USER=$(echo "$SHADOW_LINE" | awk -F: '{print $1}')

	# is this person a system user?
	SHADOW_UID=$(id -u "$SHADOW_USER")

	if [ "$SHADOW_UID" -lt 1000 ] || [ "$SHADOW_UID" -eq "65534" ]; then
		echo "$SHADOW_LINE" >> /etc/shadow.new
	fi
done

awk -F: '($3<1000) || ($3==65534)' /etc/passwd > /etc/passwd.new
awk -F: '($3<1000) || ($3==65534)' /etc/group > /etc/group.new

rm /etc/passwd
rm /etc/group
rm /etc/shadow

cat /etc/shadow.new /srv/users/shadow > /etc/shadow
cat /etc/passwd.new /srv/users/passwd > /etc/passwd
cat /etc/group.new /srv/users/group > /etc/group

echo "All done!"
