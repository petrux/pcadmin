#!/bin/bash

# define a default destination directory;
# if the custom destination directory is 
# empty (i.e. -z), then use the default one.
# Leave empty if you want "/" to be the backup
# destination directory.
DEF_DEST_DIR= 
DEST_DIR=$1
if [ -z $1 ]; then
	DEST_DIR=$DEF_DEST_DIR
fi

# generate the backup archive file name
DEST_FILE=$DEST_DIR/backup-`date +%Y-%m-%d_%H-%M-%S`.tgz
echo "backup file:" $DEST_FILE

# GO!
# exlude: DEST_DIR, /media, /proc, /lost+found, /mnt, /sys
#sudo tar -cvpzf $DEST_FILE --exclude=$DEST_DIR --exclude=/media --exclude=/proc --exclude=/lost+found --exclude=/mnt --exclude=/sys /
