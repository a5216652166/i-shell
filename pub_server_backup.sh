#!/bin/sh
#
#
#
echo "===========backup server app...==========="
tomcat_home=/opt/apache-tomcat-7.0.54
backup_dir=/home/backup/server
mkdir -p $backup_dir/server

rm -rf $backup_dir/server/*

rm -rf $tomcat_home/webapps/ROOT/files
\cp -a $tomcat_home/webapps/ROOT/* $backup_dir/server/

mysqldump -pitserver ipetty > $backup_dir/ipetty.sql

ln -sf /home/data/files $tomcat_home/webapps/ROOT

echo "===========backup server app ok==========="