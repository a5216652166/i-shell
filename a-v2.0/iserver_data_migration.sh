#!/bin/sh
#
set -e
source ./config.conf
cur_dir=$(cd "$(dirname "$0")"; pwd)

mysqldump -h115.29.103.123 -uadmin -p ipetty > /tmp/ipetty.sql
mysql -e "drop database ipetty;"
mysql -e "create database if not exists ipetty default charset utf8;"
mysql ipetty < /tmp/ipetty.sql

rm -rf $ISERVER_UPLOAD_DIR/*
scp -r $ISERVER_UPLOAD_DIR root@115.29.103.123:/home/data/files

cd $cur_dir

