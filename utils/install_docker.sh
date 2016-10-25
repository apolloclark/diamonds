#!/bin/bash

# update apt-get
export DEBIAN_FRONTEND="noninteractive"
apt-get update

# remove previously installed Docker
apt-get purge lxc-docker*
apt-get purge docker.io*

# add Docker repo
apt-get install -y apt-transport-https ca-certificates
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

cat <<'EOF' | sudo tee /etc/apt/sources.list.d/docker.list
deb https://apt.dockerproject.org/repo debian-stretch main
EOF
apt-get update

# install Docker
apt-get install -y docker-engine
service docker start
docker run hello-world


# configure Docker user group permissions
groupadd docker
gpasswd -a ${USER} docker
service docker restart

# set Docker to auto-launch on startup
systemctl enable docker
