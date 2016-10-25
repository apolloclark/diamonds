#!/bin/bash

# set the environment to be fully automated
export DEBIAN_FRONTEND="noninteractive"

# remove Jenkins, if it's running
if ps aux | grep -q ".*[j]enkins.war"; then
	echo "INFO: Jenkins found, removing."
	service jenkins stop
	apt-get remove -y jenkins
	rm -rf /var/lib/jenkins
else
	echo "INFO: Jenkins not found."
fi

# clear out staging folders
rm -rf ./vagrant-jenkins-pipeline
rm -rf /vagrant/

# clone vagrant-jenkins-pipeline, copy install files
git clone https://github.com/apolloclark/vagrant-jenkins-pipeline
cd ./vagrant-jenkins-pipeline
cp -rf ./data /vagrant/
cd ./provision

# set the install scripts to executable, run them
chmod +x ./*.sh
./bootstrap.sh
./bootstrap_python.sh
