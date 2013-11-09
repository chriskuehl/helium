#!/bin/sh
cd /etc/skel/
rm .bashrc .bash_logout 2>/dev/null
rm -rf .dotfiles dotfiles 2>/dev/null

git clone https://github.com/chriskuehl/dotfiles.git
mv dotfiles .dotfiles
cd .dotfiles
./update.py '../' 1 # use 3 parameters for a relative link

ls /home/ | 
while read USER; do
	if [ "$USER" != "deleted-users" ]; then
		echo "Update dotfiles for $USER..."
		sudo -u "$USER" "rm -r ~/.dotfiles ~/dotfiles; git clone https://github.com/chriskuehl/dotfiles.git && mv dotfiles .dotfiles && cd ~/.dotfiles && ~/.dotfiles/update.py"
	fi
done
