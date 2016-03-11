#!/bin/bash
# @see https://gorails.com/setup/ubuntu/15.10

# update, install dependencies
export DEBIAN_FRONTEND="noninteractive"
sudo apt-get update
sudo apt-get install -y git-core build-essential libssl-dev libreadline-dev \
    libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev \
    libcurl4-openssl-dev python-software-properties libffi-dev zlib1g-dev

# install Ruby rvm, ruby 2.3.0
# @see https://github.com/rbenv/ruby-build/issues/834
gpg --keyserver hkp://keys.gnupg.net --recv-keys \
    409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source /etc/profile.d/rvm.sh
echo "source /etc/profile.d/rvm.sh" >> ~/.bashrc
rvm use 2.3.0 --default --install --fuzzy



# install MySQL and sqlite
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password \"''\""
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password \"''\""
sudo apt-get install -y mysql-server mysql-client libmysqlclient-dev



# download, install, configure, run Railsgoat
git clone https://github.com/OWASP/railsgoat
cd railsgoat
gem install bundler
bundle install
sleep 10

# setup database, use MySQL
echo -e "INFO: setting up database..."
RAILS_ENV=mysql
echo 'export RAILS_ENV=mysql' >> ~/.bashrc
rake db:setup
sleep 10

# run Railsgoat
echo -e "INFO: starting railsgoat..."
rails s -b 0.0.0.0 > /dev/null &
sleep 15
firefox http://127.0.0.1:3000 &
# sudo pkill -9 ruby
