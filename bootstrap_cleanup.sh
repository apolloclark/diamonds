#!/bin/bash

#### Prevent apt-get from asking us questions while isntalling software
export DEBIAN_FRONTEND=noninteractive

#### The Debian AMI uses the Syslinux bootloader but Kali uses Grub2 so let's use Grub2
# update the grub device.map, necessary for AWS Debian for now...
grub-mkdevicemap

# set the debconf selections
debconf-set-selections <<< 'grub-installer grub-installer/only_debian boolean true'
debconf-set-selections <<< 'grub-installer grub-installer/with_other_os boolean true'
debconf-set-selections <<< 'grub-pc grub-pc/install_devices multiselect /dev/sda1'
# /dev/xvda, for AWS
# /dev/sda, for Virtualbox

# fix for when grub updates
unset UCF_FORCE_CONFFOLD
export UCF_FORCE_CONFFNEW=YES
ucf --purge /boot/grub/menu.lst

# Install grub2
apt-get -y --force-yes install grub2



# set the debconf selections
debconf-set-selections <<< 'unattended-upgrades unattended-upgrades/enable_auto_updates boolean true'
debconf-set-selections <<< 'unattended-upgrades/origins_pattern: "origin=Debian,codename=${distro_codename},label=Debian-Security";'

# delete the current unattended-upgrades file
rm -f /etc/apt/apt.conf.d/50unattended-upgrades
rm -f /etc/apt/apt.conf.d/20auto-upgrades



#### Update to the newest version of Kali
apt-get update
apt-get -y --force-yes upgrade
# apt-get -o Dpkg::Options::="--force-confnew" --force-yes -fuy dist-upgrade
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

#### Clean up after apt-get
apt-get -y autoremove --purge
apt-get -y clean

 
  

  
# @see https://raw.githubusercontent.com/averagesecurityguy/packer-debian2kali-ec2/master/scripts/cleanup.sh
# Remove SSH key pairs according to AWS requirements for shared AMIs:
# @see http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/building-shared-amis.html
# shred -u /etc/ssh/*_key /etc/ssh/*_key.pub
# shred -u /home/admin/.ssh/*
# shred -u /home/vagrant/.ssh/*

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
# update-rc.d <service> defaults, to re-enable
echo "INFO: Disabling service auto-start..."

# save the output of service status
services_status=$(service --status-all  2>&1);

if grep -q " \[ + \]  smbd" <<< "$services_status"; then
    echo "INFO: Disabling Samba / smbd"   
    service smbd stop
    update-rc.d -f smbd remove
fi

if grep -q " \[ + \]  samba" <<< "$services_status"; then
    echo "INFO: Disabling Samba"   
    service samba stop
    update-rc.d -f samba remove
fi

if grep -q " \[ + \]  samba-ad-dc" <<< "$services_status"; then
    echo "INFO: Disabling Samba / AD-DC"   
    service samba-ad-dc stop
    update-rc.d -f samba-ad-dc remove
fi

if grep -q " \[ + \]  nmbd" <<< "$services_status"; then
    echo "INFO: Disabling NetBIOS"   
    service nmbd stop
    update-rc.d -f nmbd remove
fi

if grep -q " \[ + \]  apache2" <<< "$services_status"; then
    echo "INFO: Disabling Apache"   
    service apache2 stop
    update-rc.d -f apache2 remove
fi

if grep -q " \[ + \]  mysql" <<< "$services_status"; then 
    echo "INFO: Disabling MySQL"  
    service mysql stop
    update-rc.d -f mysql remove
fi

if grep -q " \[ + \]  postgresql" <<< "$services_status"; then
    echo "INFO: Disabling Postgres"   
    service postgresql stop
    update-rc.d -f postgresql remove
fi

if grep -q " \[ + \]  dradis" <<< "$services_status"; then  
    echo "INFO: Disabling Dradis" 
    service dradis stop
    update-rc.d -f dradis remove
fi

if grep -q " \[ + \]  beef-xss" <<< "$services_status"; then 
    echo "INFO: Disabling Beef-XSS"  
    service beef-xss stop
    update-rc.d -f beef-xss remove
fi
