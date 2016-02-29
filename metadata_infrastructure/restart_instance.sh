#!/usr/bin/env bash
sudo service elasticsearch start
gem install compass
cd  /vagrant/metadata && mvn clean package -DskipTests -DbuildNumber=stage
cd /vagrant/metadata && nohup java -Dimages.originals=file:/vagrant/metadata/images/originals/ -Dimages.resized=file:/vagrant/metadata/images/resized/  -jar  target/metadata-stage.jar &
export METADATA_FILESERVER_DIR=$HOME/fileserver
export METADATA_IMAGES_COLLECTION=/vagrant/images
#or put it in .bashrc
s3fs ti-zoral-dev var
cd /vagrant && ln -s ~/var/product_images/ images

screen -S fileserver
screen -S sinatra