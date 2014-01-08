#!/bin/bash

# define a default destination directory;
# if the custom destination directory is 
# empty (i.e. -z), then use the default one.
# Leave empty if you want "/" to be the backup
# destination directory.
DEF_DEST_DIR=/tmp
DEST_DIR=$1
if [ -z $1 ]; then
	DEST_DIR=$DEF_DEST_DIR
fi

# create the actual backup subdir
DEST_DIR=$DEST_DIR/`whoami`-`hostname`-backup-`date +%Y-%m-%d_%H-%M-%S`
echo "user:" `whoami`
echo "host:" `hostname`
echo "backup directory:" $DEST_DIR

echo "creating the backup directory..."
mkdir $DEST_DIR

echo "repository keys..."
sudo apt-key exportall > $DEST_DIR/Repo.keys

echo "sources list..."
sudo cp /etc/apt/sources.list $DEST_DIR/sources.list

echo "packages list..."
dpkg --get-selections > $DEST_DIR/Package.list

echo "python packages (via pip)..."
pip freeze > $DEST_DIR/requirements.txt

cp restore.sh $DEST_DIR
chmod 775 $DEST_DIR/restore.sh

# GO!
# exlude: DEST_DIR, /media, /proc, /lost+found, /mnt, /sys
#sudo tar -cvpzf $DEST_FILE --exclude=$DEST_DIR --exclude=/media --exclude=/proc --exclude=/lost+found --exclude=/mnt --exclude=/sys /

echo "done!"
echo
