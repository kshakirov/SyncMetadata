#!/usr/bin/env bash
sudo apt-get install -y build-essential libfuse-dev libcurl4-openssl-dev libxml2-dev mime-support automake libtool
wget https://github.com/s3fs-fuse/s3fs-fuse/archive/v1.77.tar.gz
mv v1.77.tar.gz s3fs-fuse-1.77.tar.gz
tar zxvf s3fs-fuse-1.77.tar.gz
cd s3fs-fuse-1.77/
./autogen.sh
./configure --prefix=/usr
make
sudo make install
cd ~/SyncMetadata/metadata_infrastructure
cp passwd-s3fs ~/.passwd-s3fs
chmod 600 ~/.passwd-s3fs
