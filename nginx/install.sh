#!/bin/sh
#
#
#安装Nginx

echo "正在安装Nginx..."
\cp -av nginx.repo /etc/yum.repos.d/

yum -y install nginx
chkconfig nginx on
service nginx start
nginx -V
echo "===========Nginx ok==========="