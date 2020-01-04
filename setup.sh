#!/bin/bash

# Set Server Hostname and Host Node in Backup Script passed in the arguments
sed -i s/^SERVER_HOSTNAME=.*/SERVER_HOSTNAME=$1/ /root/Cpanel-Gdrive/backup.sh
sed -i s/^NODE=.*/NODE=$2/ /root/Cpanel-Gdrive/backup.sh

# Run cron.sh for adding cronjob
bash /root/Cpanel-Gdrive/cron.sh "$3"

# Install rclone https://rclone.org
curl https://rclone.org/install.sh | sudo bash
wait

# Link your Google Account to rclone by creating New Remote
rclone config
wait

