#!/bin/sh
#http://www.cnoswiki.com/2012/11/centos-yum-install-tomcat6.html

yum install tomcat6 tomcat6-webapps tomcat6-admin-webapps -y
service tomcat6 start
service tomcat6 stop
service tomcat6 restart
#�������Ϸ�����װtomcat6Ĭ��Ŀ¼��/usr/share/tomcat6/��
#�����ļ�Ĭ��Ŀ¼��/etc/tomcat6/��