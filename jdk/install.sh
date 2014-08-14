#!/bin/sh
#²Î¿¼£ºhttp://blog.csdn.net/horace20/article/details/26516689 

wget -O jdk-7u6-linux-x64.rpm --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u15-b03/jdk-7u15-linux-x64.rpm"
rpm -ivh jdk-7u6-linux-x64.rpm
#yum install java-1.7.0-openjdk
