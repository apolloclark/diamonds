#!/bin/bash

#### Prevent apt-get from asking us questions while isntalling software
export DEBIAN_FRONTEND="noninteractive"

# @see http://wiki.x2go.org/doku.php/doc:installation:x2goserver
# x2go
sudo apt-key adv --recv-keys --keyserver keys.gnupg.net E1F958385BFE2B6E

sudo cat >> /etc/apt/sources.list <<'EOF'
# X2Go Repository (release builds)
deb http://packages.x2go.org/debian jessie main
# X2Go Repository (sources of release builds)
deb-src http://packages.x2go.org/debian jessie main
EOF

sudo apt-get update
sudo apt-get install x2go-keyring && apt-get update
sudo apt-get install -y x2goserver x2goserver-xsession