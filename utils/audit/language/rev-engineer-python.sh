#!/bin/bash

# Script to reverse engineer a Python based system

# make folder
sudo mkdir -p /tmp/rev-language
cd /tmp/rev-language

# get version
python --version > 01.version.txt

# get package manager version, sources
pip --version > 02.pip.txt

# get plugins, versions
pip list >> 02.pip.txt

# get config files

# get project folders
