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

mkdir $DEST_DIR
sudo apt-key exportall > $DEST_DIR/Repo.keys
sudo cp -p /etc/apt/sources.list $DEST_DIR/sources.list
dpkg --get-selections > $DEST_DIR/Package.list
pip freeze > $DEST_DIR/requirements.txt
rsync -a --progress --exclude=Downloads --exclude=Dropbox --exclude= /home/`whoami` $DEST_DIR
rsync -a --progress /opt $DEST_DIR
cp restore.sh $DEST_DIR
chmod 775 $DEST_DIR/restore.sh

echo $DEST_DIR " ...done!"
echo 
echo
