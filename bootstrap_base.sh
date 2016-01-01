#!/bin/bash

#### Prevent apt-get from asking us questions while isntalling software
export DEBIAN_FRONTEND="noninteractive"

# @see https://github.com/averagesecurityguy/packer-debian2kali-ec2/blob/master/scripts/grub.sh
# set -e
# set -o pipefail




#### Overwrite the default Debian mirrors/sources with the Kali mirrors/sources
sudo cat >> /etc/apt/sources.list <<'EOL'

deb http://http.kali.org/kali sana main non-free contrib
deb-src http://http.kali.org/kali sana main non-free contrib

deb http://security.kali.org/kali-security/ sana/updates main contrib non-free
deb-src http://security.kali.org/kali-security/ sana/updates main contrib non-free
EOL

#### Download and import the official Kali Linux key
wget -q -O - https://www.kali.org/archive-key.asc | gpg --import
gpg -a --export ED444FF07D8D0BF6 | sudo apt-key add -

#### Update our apt db
sudo apt-get update -y

#### Install the Kali keyring
sudo apt-get install -y --force-yes kali-archive-keyring



#### Preconfigure things so our install will work without any user input
## mysql
pass="passw0rd"; # $(head -c 24 /dev/urandom | base64)
echo "MySQL Root Password: $pass"
debconf-set-selections <<< "mysql-server-5.5 mysql-server/root_password password $pass"
debconf-set-selections <<< "mysql-server-5.5 mysql-server/root_password_again password $pass"

## Kismet
debconf-set-selections <<< 'kismet kismet/install-setuid boolean false'
debconf-set-selections <<< 'kismet kismet/install-users string'

## sslh
debconf-set-selections <<< 'sslh sslh/inetd_or_standalone select standalone'

## macchanger
debconf-set-selections <<< 'macchanger macchanger/automatically_run boolean false'

## wireshark
debconf-set-selections <<< 'wireshark-common wireshark-common/install-setuid boolean false'



# create the "admin" user, if necessary
if ! id -u admin > /dev/null 2>$1; then
    sudo adduser  --disabled-password --gecos "" --shell /bin/bash --ingroup sudo admin
    sudo chown -R admin /home/admin
    echo "admin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
fi



# install basic utilities, base kali package
sudo apt-get update -y
sudo apt-get -q -y --force-yes install \
	debconf-utils build-essential linux-headers-$(uname -r) kali-linux
