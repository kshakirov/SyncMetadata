#!/usr/bin/env bash
sudo service elasticsearch start
gem install compass
cd  /vagrant/metadata && mvn clean package -DskipTests -DbuildNumber=stage
nohup java -jar /vagrant/metadata/target/metadata-stage.jar &
export METADATA_FILESERVER_DIR=$HOME/fileserver
export METADATA_IMAGES_COLLECTION=/vagrant/images
#or put it in .bashrc
