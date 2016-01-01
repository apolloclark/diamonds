#!/bin/bash

# set the shell to be non-interactive
export DEBIAN_FRONTEND="noninteractive"

# install the meta package
sudo apt-get -q -y --force-yes install kali-linux-all


# veil-evasion
# Please enter the path of your metasploit installation
# /opt/metasploit-framework/
# sudo apt-get install -y veil-evasion
# sudo debconf-show veil-evasion
# sudo debconf-get-selections | grep <package>