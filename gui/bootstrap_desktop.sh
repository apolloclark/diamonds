#!/bin/bash

#### Prevent apt-get from asking us questions while isntalling software
export DEBIAN_FRONTEND="noninteractive"

# Pre-answer the various install questions
cat << EOF | debconf-set-selections
keyboard-configuration keyboard-configuration/layout select USA
keyboard-configuration keyboard-configuration/variant select USA
EOF

# install Gnome desktop
sudo apt-get -y install kali-desktop-gnome



# install Vino VNC
sudo apt-get -y install vino

# setup Gnome to autologin the "admin" user
sudo sed -i '7c\AutomaticLoginEnable = true' /etc/gdm3/daemon.conf
sudo sed -i '8c\AutomaticLogin = admin' /etc/gdm3/daemon.conf
sudo sed -i '11c\TimedLoginEnable = true' /etc/gdm3/daemon.conf

# start Vino on system startup
sudo tee -a /home/admin/.profile <<'EOF'

# set Vino to run, if it's not
ps cax | grep "vino-server" > /dev/null
if [ $? -eq 0 ]; then
    echo "Vino VNC is already running."
else
    echo "Starting Vino VNC..."

    # configure Vino to only listen to localhost, unecrypted
    export DISPLAY=:0.0
    gsettings set org.gnome.Vino authentication-methods "['none']"
    gsettings set org.gnome.Vino require-encryption false
    gsettings set org.gnome.Vino network-interface lo
    gsettings set org.gnome.Vino prompt-enabled false
    gsettings set org.gnome.Vino notify-on-connect false
    nohup /usr/lib/vino/vino-server &> /dev/null &
fi

EOF
