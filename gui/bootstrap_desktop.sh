#!/bin/bash

#### Prevent apt-get from asking us questions while isntalling software
export DEBIAN_FRONTEND="noninteractive"

# Pre-answer the various install questions
cat << EOF | debconf-set-selections
keyboard-configuration keyboard-configuration/layout select USA
keyboard-configuration keyboard-configuration/variant select USA
EOF

# install Gnome desktop, 3.21.90
apt-get -y install kali-desktop-gnome



# install Vino VNC
apt-get -y install vino

# setup Gnome to autologin the "admin" user
sed -i '7c\AutomaticLoginEnable = true' /etc/gdm3/daemon.conf
sed -i '8c\AutomaticLogin = admin' /etc/gdm3/daemon.conf
sed -i '11c\TimedLoginEnable = true' /etc/gdm3/daemon.conf

# start Vino on system startup
cat > /home/$(whoami)/.profile <<'EOF'

# set Vino to run, if it's not
ps cax | grep "vino-server" > /dev/null
if [ $? -eq 0 ]; then
    echo "Vino VNC is already running."
else
    echo "Starting Vino VNC..."

    # configure Vino to only listen to localhost, unecrypted
    export DISPLAY=:0.0
    gsettings set org.gnome.desktop.lockdown disable-lock-screen true
    gsettings set org.gnome.desktop.lockdown disable-user-switching true
    gsettings set org.gnome.desktop.lockdown disable-log-out true
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 0
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
    gsettings set org.gnome.desktop.screensaver lock-enabled false
    gsettings set org.gnome.desktop.session idle-delay 0
    xset s off # don't activate screensaver
    xset -dpms # disable DPMS (Energy Star) features.
    xset s noblank # don't blank the video device
    
    dconf write /org/gnome/empathy/notifications/notifications-enabled false
    
    gsettings set org.gnome.Vino authentication-methods "['none']"
    gsettings set org.gnome.Vino require-encryption false
    gsettings set org.gnome.Vino network-interface lo
    gsettings set org.gnome.Vino prompt-enabled false
    gsettings set org.gnome.Vino notify-on-connect false
    gsettings set org.gnome.Vino lock-screen-on-disconnect false
    
    nohup /usr/lib/vino/vino-server --sm-disable &> /dev/null &
fi

EOF
