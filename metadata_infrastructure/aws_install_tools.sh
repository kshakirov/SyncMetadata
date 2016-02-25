#!/usr/bin/env bash
sudo apt-get install zip -y
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
mkdir ~/.aws
cp aws/* ~/.aws
cd ~
aws s3 cp s3://ti-zoral-dev/original.tar.gz .