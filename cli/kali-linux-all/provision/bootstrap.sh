#!/bin/bash

# set the shell to be non-interactive
export DEBIAN_FRONTEND="noninteractive"

# install the meta package
sudo apt-get -qq -y --allow-downgrades --allow-remove-essential \
    --allow-change-held-packages install kali-linux-all
