#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'Usage ./aws_user.sh username
for ex: ./aws_user.sh prod'
    exit 1
fi

aws iam create-user --user-name $1
aws iam create-access-key --user-name $1
aws iam attach-user-policy --policy-arn arn:aws:iam::aws:policy/AWSDeepRacerCloudFormationAccessPolicy --user-name prod
aws iam attach-user-policy --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess --user-name prod
aws iam upload-ssh-public-key --user-name $1 --ssh-public-key-body file://~/.ssh/$1.pub
