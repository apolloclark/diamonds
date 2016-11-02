#!/bin/bash

# sudo shutdown -r now
cat <<'EOL' | sudo tee /etc/apt/sources.list

# kali-rolling
deb http://http.kali.org/kali kali-rolling main contrib non-free
deb-src http://http.kali.org/kali kali-rolling main contrib non-free
EOL

sudo apt-get update
sudo apt-get install -y locate
sudo updatedb

git clone https://github.com/gauntlt/gauntlt
cd gauntlt
# write out new install_gauntlt_deps.sh
source ./install_gauntlt_deps.sh
echo '[[ -r ~/.bashrc ]] && . ~/.bashrc' >> ~/.profile
bash ./ready_to_rumble.sh
gauntlt
