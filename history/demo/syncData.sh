#!/bin/sh
#
# 
# 

echo "=================export remote database to win.sql================"
mysqldump -h 172.16.3.1 -uadmin -pitserver  --single-transaction win -r win.sql
mysql -uroot -pitserver -e "create database if not exists win default charset utf8;"

echo "=================into local database================"
mysql -uroot -pitserver win < win.sql


echo "=================OK================"