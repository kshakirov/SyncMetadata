#!/usr/bin/env bash
cd ~/SyncMetadata
export RAILS_ENV=development
bundle install
bundle exec rake db:migrate
screen -S fileserver
export METADATA_FILESERVER_DIR=$HOME/fileserver
export METADATA_IMAGES_COLLECTION=/vagrant/images
ln -s ~/var/product_images/ images

#carefull about fileserver start it from right folder