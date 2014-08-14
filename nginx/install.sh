#!/bin/sh
#
#
#安装Nginx

echo "正在安装Nginx..."
rpm -ivh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
#\cp -av nginx.repo /etc/yum.repos.d/

yum -y install nginx
chkconfig nginx on
service nginx start
nginx -V
echo "===========Nginx ok==========="