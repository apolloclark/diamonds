#!/bin/bash

#### Prevent apt-get from asking us questions while isntalling software
export DEBIAN_FRONTEND="noninteractive"

sudo -E apt-get update
sudo apt-get install xfce4 xrdp xfce4-goodies
echo xfce4-session > ~/.xsession
# sudo cp /home/ubuntu/.xsession /etc/skel