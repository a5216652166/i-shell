#!/bin/sh
#http://www.cnoswiki.com/2012/11/centos-yum-install-tomcat6.html

rpm -ivh http://mirrors.ustc.edu.cn/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum -y install yum-priorities #这个是jpackage依赖的包要先装                                
rpm -Uvh ftp://ftp.pbone.net/mirror/www.jpackage.org/jpackage/6.0/generic/free/RPMS/jpackage-release-6-3.jpp6.noarch.rpm
#yum  install tomcat7 tomcat7-webapps tomcat7-admin-webapps tomcat-native  -y
yum  install tomcat tomcat-webapps tomcat-admin-webapps tomcat-native java-1.7.0-openjdk-devel  -y

service tomcat start
service tomcat stop
service tomcat restart
#按照以上方法安装tomcat6默认目录在/usr/share/tomcat6/下
#配置文件默认目录在/etc/tomcat6/下