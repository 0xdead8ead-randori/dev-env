#!/usr/bin/env bash
#
# Script that starts up services
#

# Do any other house cleaning here:
ln -s /workspace $HOME/workspace
chown $USER:$USER /workspace

# Start SSH Server
echo "####################### Dev-Env #######################"
echo -e "\n\n    Starting Dev-Env SSH Server:  ssh dev-env.local\n\n"
echo "####################### Dev-Env #######################"
sudo /usr/sbin/sshd -D
