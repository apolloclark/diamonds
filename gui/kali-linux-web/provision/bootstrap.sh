#!/bin/bash

#### Prevent apt-get from asking us questions while isntalling software
export DEBIAN_FRONTEND="noninteractive"

#### Install the base software
# List taken from the official Kali-live-build script at: 
# http://git.kali.org/gitweb/?p=live-build-config.git;a=blob_plain;f=config
# /package-lists/kali.list.chroot;hb=HEAD
apt-get -q -y --force-yes install kali-linux-web
