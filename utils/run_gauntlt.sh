#!/bin/bash

# use RVM
source /etc/profile.d/rvm.sh
rvm use 2.3.0 --default --install --fuzzy
export DIRB_WORDLISTS=`locate dirb | grep "/dirb/wordlists$"`
export SSLYZE_PATH=`which sslyze`

# change focus to the Gauntlt folder
cd ~/gauntlt/

# verify that Gruyere is running
if ! ps aux | grep -q "[g]ruyere"; then
	echo "Launching Gruyere..."
	cd ./vendor/gruyere/
	source manual_launch.sh
	cd ~/gauntlt/
else
	echo "Gruyere already running..."
fi

# check we're ready
bash ./ready_to_rumble.sh

# run the .attack files
gauntlt
