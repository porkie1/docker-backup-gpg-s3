#!/bin/sh

BACKUP_NAME="${NAME_PREFIX}_`date +"%Y-%m-%d_%H-%M"`"

cd /backup
tar cJf ~/$BACKUP_NAME.tar.xz ./*
cd /

gpg --trust-model always --output ~/$BACKUP_NAME.tar.xz.gpg --encrypt --recipient $GPG_RECIPIENT ~/$BACKUP_NAME.tar.xz
rm ~/$BACKUP_NAME.tar.xz

b2 upload_files $B2_BUCKET_NAME ~/$BACKUP_NAME.tar.xz.gpg $BACKUP_NAME.tar.xz.gpg
rm ~/$BACKUP_NAME.tar.xz.gpg
