#!/bin/bash

# Assign values to parameters that will be used in Script
DATE=$(date +%Y-%m-%d)
BACKUP_DIR=/backup
SERVER_HOSTNAME=
NODE=

# Create fresh backup directory
mkdir -p "$BACKUP_DIR/$DATE"

echo "~~~~~~~~~~~~~~ Starting BACKUP Creation and Upload to Google Drive ~~~~~~~~~~~~~~"
echo $DATE
start=$SECONDS
ls -1 /var/cpanel/users -Isystem | while read user; do
/scripts/pkgacct $user $BACKUP_DIR/$DATE --backup --skiplogs --skipbwdata --nocompress > /dev/null
wait
rclone copy $BACKUP_DIR/$DATE gdrive:basezap"$NODE"nodebackups/$SERVER_HOSTNAME/$DATE
wait
rm -f $BACKUP_DIR/$DATE/*
wait
done
echo "~~~~~~~~~~~~~~ Backup Creation and Upload to Google Drive Finished ~~~~~~~~~~~~~~"
duration=$(( SECONDS - start ))
echo "Total Time Taken $duration Seconds"

# Remove backup directory
rm -rf $BACKUP_DIR/$DATE

exit
