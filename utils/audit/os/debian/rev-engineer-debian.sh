#!/bin/bash

# Script to reverse engineer the basic build actions need to setup a given
# server. This script is optimized for Debian systems.
# @see https://www.reddit.com/r/devops/comments/3w49pw/
# upsidedown_configuration_management_what_tool/

# setup folders
cd /tmp
mkdir -p /tmp/rev-build

# history
echo history > 01-history.txt

# system
echo uname -r > 02-system.txt

# system users
sudo cat /etc/passwd > 03-users.txt

# ssh keys
# sudo cp /home/*/.ssh/* ./

# file system
sudo lslbk > 04-filesystem.txt
sudo df -h >> 04-filesystem.txt

# network
sudo netstat -tunlp > 05-network.txt

# firewall rules
sudo iptables -L > 06-firewall.txt

# processes
sudo ps aux > 07-processes.txt

# services
sudo service --status-all > 08-services.txt

# apt repos
sudo cat /etc/apt/sources.lst > 09-apt-sources.txt

# zip it up, delete files
tar -zcvf reverse-engineered-build.gz /tmp/rev-build
