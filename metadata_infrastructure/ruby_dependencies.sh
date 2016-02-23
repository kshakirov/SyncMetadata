#!/usr/bin/env bash
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E
\curl -sSL https://get.rvm.io | bash -s stable
source /home/ubuntu/.rvm/scripts/rvm
rvm install ruby-2.2.3
apt-get install libmysqlclient-dev
sudo apt-get install libgmp3-dev
sudo apt-get install imagemagick
gem install bundler
create user 'vagrant'@'localhost' identified by 'vagrant';
grant all on metadata.* to 'vagrant'@'localhost';