#!/bin/sh
#
#
#
echo "===========revert server app...==========="
tomcat_home=/opt/apache-tomcat-7.0.52
backup_dir=/home/backup/server
mkdir -p $backup_dir

service tomcat stop

mysql -pitserver -e "create database if not exists ipet default charset utf8;"
mysql -pitserver ipet < $backup_dir/ipet.sql

rm -rf $tomcat_home/webapps/ROOT/*
\cp -a  $backup_dir/server/* $tomcat_home/webapps/ROOT/*
ln -sf /home/data/files $tomcat_home/webapps/ROOT

service tomcat start
tail -f $tomcat_home/logs/catalina.out

echo "===========revert server app ok==========="