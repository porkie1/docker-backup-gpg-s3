#!/bin/sh

BACKUP_NAME="${NAME_PREFIX}_`date +"%Y-%m-%d_%H-%M"`"

cd /backup
tar cJf ~/$BACKUP_NAME.tar.xz ./*
cd /

gpg --trust-model always --output ~/$BACKUP_NAME.tar.xz.gpg --encrypt --recipient $GPG_RECIPIENT ~/$BACKUP_NAME.tar.xz
rm ~/$BACKUP_NAME.tar.xz

aws s3 cp ~/$BACKUP_NAME.tar.xz.gpg s3://$BACKUP_NAME.tar.xz.gpg --storage-class STANDARD --region $AWS_DEFAULT_REGION
rm ~/$BACKUP_NAME.tar.xz.gpg
