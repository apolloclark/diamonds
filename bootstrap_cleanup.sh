#!/bin/bash

#### Prevent apt-get from asking us questions while isntalling software
export DEBIAN_FRONTEND=noninteractive

#### The Debian AMI uses the Syslinux bootloader but Kali uses Grub2 so let's use Grub2
# update the grub device.map, necessary for AWS Debian for now...
sudo grub-mkdevicemap

# set the debconf selections
debconf-set-selections <<< 'grub-installer grub-installer/only_debian boolean true'
debconf-set-selections <<< 'grub-installer grub-installer/with_other_os boolean true'
debconf-set-selections <<< 'grub-pc grub-pc/install_devices multiselect /dev/sda'
# /dev/xvda, for AWS
# /dev/sda, for Virtualbox

# fix for when grub updates
unset UCF_FORCE_CONFFOLD
export UCF_FORCE_CONFFNEW=YES
ucf --purge /boot/grub/menu.lst

# Install grub2
apt-get -y --force-yes install grub2



#### Update to the newest version of Kali
sudo apt-get update
sudo apt-get -y --force-yes upgrade
sudo apt-get -o Dpkg::Options::="--force-confnew" --force-yes -fuy dist-upgrade

#### Clean up after apt-get
sudo apt-get -y autoremove --purge
sudo apt-get -y clean

 
  

  
# @see https://raw.githubusercontent.com/averagesecurityguy/packer-debian2kali-ec2/master/scripts/cleanup.sh
# Remove SSH key pairs according to AWS requirements for shared AMIs:
# @see http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/building-shared-amis.html
# sudo shred -u /etc/ssh/*_key /etc/ssh/*_key.pub
# sudo shred -u /home/admin/.ssh/*
# sudo shred -u /home/vagrant/.ssh/*

# Wipe our logs
echo "INFO: Cleaning log files and history..."
echo > /var/log/auth.log
echo > /var/log/cloud-init.log
echo > /var/log/daemon.log
echo > /var/log/debug
echo > /var/log/dmesg
rm -rf /var/log/dmesg.*
echo > /var/log/dpkg.log
echo > /var/log/kern.log
echo > /var/log/lastlog
echo > /var/log/messages
echo > /var/log/pm-powersave.log
echo > /var/log/syslog
echo > /var/log/user.log
echo > /var/log/wtmp
echo > /var/log/Xorg.0.log
echo > /var/log/apt/history.log
# echo > /var/log/ConsoleKit/history
# echo > /var/log/gdm3/:0-greeter.log
# echo > /var/log/gdm3/:0.log
# echo > /var/log/gdm3/:0-slave.log

# Clear our Bash history
history -c
history -w





# Disable services auto-starting, for better security
# @see http://manpages.ubuntu.com/manpages/hardy/man8/update-rc.d.8.html
# sudo update-rc.d <service> defaults, to re-enable
echo "INFO: Disabling service auto-start..."

# save the output of service status
services_status=$(sudo service --status-all  2>&1);

if grep -q " \[ + \]  apache2" <<< "$services_status"; then
    echo "INFO: Disabling Apache"   
    sudo service apache2 stop
    sudo update-rc.d -f apache2 remove
fi

if grep -q " \[ + \]  mysql" <<< "$services_status"; then 
    echo "INFO: Disabling MySQL"  
    sudo service mysql stop
    sudo update-rc.d -f mysql remove
fi

if grep -q " \[ + \]  postgresql" <<< "$services_status"; then
    echo "INFO: Disabling Postgres"   
    sudo service postgresql stop
    sudo update-rc.d -f postgresql remove
fi

if grep -q " \[ + \]  dradis" <<< "$services_status"; then  
    echo "INFO: Disabling Dradis" 
    sudo service dradis stop
    sudo update-rc.d -f dradis remove
fi

if grep -q " \[ + \]  beef-xss" <<< "$services_status"; then 
    echo "INFO: Disabling Beef-XSS"  
    sudo service beef-xss stop
    sudo update-rc.d -f beef-xss remove
fi
