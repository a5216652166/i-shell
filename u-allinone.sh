#!/bin/sh
#
#
yum install wget ntp zip unzip -y
chkconfig ntpd on
service ntpd start

./u-jdk.sh
./u-ant.sh
./u-maven.sh
./u-androidsdk.sh
./u-mysql.sh
./u-tomcat.sh