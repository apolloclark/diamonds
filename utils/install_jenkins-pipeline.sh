#!/bin/bash

# clone vagrant-jenkins-pipeline, install it
cd ~/
git clone https://github.com/apolloclark/vagrant-jenkins-pipeline
cd ./vagrant-jenkins-pipeline
sudo cp -R ./data /vagrant/
cd ./provision
sudo bash ./bootstrap.sh
sudo bash ./bootstrap_python.sh
