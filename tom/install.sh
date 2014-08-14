#!/bin/sh
#http://www.cnoswiki.com/2012/11/centos-yum-install-tomcat6.html

yum install tomcat6 tomcat6-webapps tomcat6-admin-webapps -y
service tomcat6 start
service tomcat6 stop
service tomcat6 restart
#按照以上方法安装tomcat6默认目录在/usr/share/tomcat6/下
#配置文件默认目录在/etc/tomcat6/下