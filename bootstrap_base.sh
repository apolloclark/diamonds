#!/bin/bash

#### Prevent apt-get from asking us questions while isntalling software
export DEBIAN_FRONTEND="noninteractive"

# @see https://github.com/averagesecurityguy/packer-debian2kali-ec2/blob/master/scripts/grub.sh
# set -e
# set -o pipefail




# who are we?
whoami
pwd
uname -a

#### Overwrite the default Debian mirrors/sources with the Kali mirrors/sources
cat <<'EOF' | tee /etc/apt/sources.list

# kali-rolling
deb http://http.kali.org/kali kali-rolling main contrib non-free
deb-src http://http.kali.org/kali kali-rolling main contrib non-free
EOF

#### Download and import the official Kali Linux key
wget -q -O - https://www.kali.org/archive-key.asc | gpg --import
gpg -a --export ED444FF07D8D0BF6 | apt-key add -

#### Update our apt db
apt-get update -y

#### Install the Kali keyring
apt-get install -y --force-yes kali-archive-keyring



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

## libc6
debconf-set-selections <<< 'libc6 libraries/restart-without-asking boolean true'



# create the "admin" user, if necessary
if ! id -u admin > /dev/null 2>&1; then
    adduser  --disabled-password --gecos "" --shell /bin/bash --ingroup admin
    chown -R admin /home/admin
    echo "admin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
fi



# install basic utilities, base kali package, kernel headers
apt-get update -y
apt-get -q -y --force-yes install \
	debconf-utils build-essential mlocate kali-linux ".*linux-headers";



#### Overwrite the default Debian mirrors/sources with the Kali mirrors/sources
cat <<'EOF' | tee /etc/apt/sources.list

# kali-rolling
deb http://http.kali.org/kali kali-rolling main contrib non-free
deb-src http://http.kali.org/kali kali-rolling main contrib non-free
EOF

# Autoresize the root EBS partition
if [[ $(df -h | grep 'xvda1') ]]; then
    /sbin/parted ---pretend-input-tty /dev/xvda resizepart 1 yes 100%
    resize2fs /dev/xvda1
fi

