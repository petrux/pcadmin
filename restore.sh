#!/bin/bash

# this restore file is intended to be placed
# within the backup directory created by the
# ./backup.sh script.

sudo rsync -a --progress `whoami` /home/
sudo rsync -a --progress ./opt /
sudo apt-key add Repo.keys
sudo cp sources.list /etc/apt/sources.list 
sudo apt-get update
sudo apt-get install dselect
sudo dpkg --set-selections < Package.list
sudo apt-get dselect-upgrade -y
sudo pip install -r requirements.txt
