#!/bin/sh
#�ο���http://blog.csdn.net/horace20/article/details/26516689 

#for centos7 http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
rpm -ivh http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
#wget http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
#yum localinstall mysql-community-release-el6-*.noarch.rpm  

yum install mysql-community-server -y
mysqladmin -u root password 'itserver'