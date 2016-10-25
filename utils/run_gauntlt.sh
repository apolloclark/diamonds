#!/bin/bash

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
bash ./ready_to_rumble.sh
gauntlt
