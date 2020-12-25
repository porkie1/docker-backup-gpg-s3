#!/bin/sh

BACKUP_DATE=$(date +"%Y-%m-%d_%H-%M")

cd /backup
tar cJf ~/$S3_BUCKET_NAME$BACKUP_DATE.tar.xz ./*
cd /

gpg --trust-model always --output ~/$S3_BUCKET_NAME$BACKUP_DATE.tar.xz.gpg --encrypt --recipient $GPG_RECIPIENT ~/$S3_BUCKET_NAME$BACKUP_DATE.tar.xz
rm ~/$S3_BUCKET_NAME$BACKUP_DATE.tar.xz

aws s3 cp ~/$S3_BUCKET_NAME$BACKUP_DATE.tar.xz.gpg s3://$S3_BUCKET_NAME/$S3_BUCKET_NAME$BACKUP_DATE.tar.xz.gpg --storage-class STANDARD_IA --region $AWS_DEFAULT_REGION
rm ~/$S3_BUCKET_NAME$BACKUP_DATE.tar.xz.gpg
