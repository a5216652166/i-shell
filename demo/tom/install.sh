#!/bin/sh
#http://www.cnoswiki.com/2012/11/centos-yum-install-tomcat6.html

rpm -ivh http://mirrors.ustc.edu.cn/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum -y install yum-priorities #�����jpackage�����İ�Ҫ��װ                                
rpm -Uvh ftp://ftp.pbone.net/mirror/www.jpackage.org/jpackage/6.0/generic/free/RPMS/jpackage-release-6-3.jpp6.noarch.rpm
#yum  install tomcat7 tomcat7-webapps tomcat7-admin-webapps tomcat-native  -y
yum  install tomcat tomcat-webapps tomcat-admin-webapps tomcat-native java-1.7.0-openjdk-devel  -y

service tomcat start
service tomcat stop
service tomcat restart
#�������Ϸ�����װtomcat6Ĭ��Ŀ¼��/usr/share/tomcat6/��
#�����ļ�Ĭ��Ŀ¼��/etc/tomcat6/��