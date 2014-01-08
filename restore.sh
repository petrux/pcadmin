#!/bin/bash

# this restore file is intended to be placed
# within the backup directory created by the
# ./backup.sh script.

echo "restoring repository keys..."
sudo apt-key add Repo.keys

echo "restoring sources list (and update)..."
sudo cp sources.list /etc/apt/sources.list 
sudo apt-get update

echo "restoring packages..."
sudo apt-get install dselect
sudo dpkg --set-selections < Package.list
sudo apt-get dselect-upgrade -y

echo "restoring python packages (via pip)..."
pip install -r requirements.txt
