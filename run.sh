#!/bin/sh

# Import GPG public keys
gpg --import /keys/*
b2 authorize-account $B2_KeyID $B2_AccessKey

# Create and install crontab file
echo "$CRON_INTERVAL /backup.sh" >> /backup.cron

crontab /backup.cron

tail -f /dev/null
