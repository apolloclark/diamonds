#!/bin/bash

# set the shell to be non-interactive
export DEBIAN_FRONTEND="noninteractive"

# install the meta package
sudo apt-get -q -y --force-yes install kali-linux-gpu
