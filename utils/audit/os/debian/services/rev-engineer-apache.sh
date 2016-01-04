#!/bin/bash

# Script to reverse engineer the basic build actions need to setup a given
# server. This script is optimized for Debian systems.

# setup folders
cd /tmp
mkdir -p /tmp/rev-build

# history
echo history > 01-history.txt

# system users
sudo cat /etc/passwd > 02-users.txt

# ssh keys

# file system
sudo lslbk > 03-filesystem.txt
sudo df -h >> 03-filesystem.txt

# network
sudo netstat -tunlp > 03-network.txt

# firewall rules
sudo iptables -L > 04-firewall.txt

# processes
sudo ps aux > 04-processes.txt

# services
sudo service --status-all > 05-services.txt

# apt repos
sudo cat /etc/apt/sources.lst > 06-apt-sources.txt
