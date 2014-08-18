#!/bin/sh
#http://techtraits.com/jetty9install/

yum install jpackage-utils -y

curl https://packagecloud.io/install/repositories/visibilityspots/yum-repo-server/script.rpm | bash

#yum install jetty-9-1.3.noarch
yum install jetty.noarch


#yum install java-1.7.0-openjdk java-1.7.0-openjdk-devel -y

#wget -P /etc/yum.repos.d/ http://jpackage.org/jpackage.repo


#yum install jetty-eclipse

#wget http://download.eclipse.org/jetty/stable-9/dist/jetty-distribution-9.1.1.v20140108.tar.gz
#tar -xzvf jetty-distribution-9.1.1.v20140108.tar.gz
#mv jetty-distribution-9.1.1.v20140108 /opt/jetty

#useradd jetty
#chown -R jetty:jetty /opt/jetty

#ln -s /opt/jetty/bin/jetty.sh /etc/init.d/jetty

#chkconfig --add jetty
#chkconfig jetty on

#vim /etc/init.d/jetty
#JETTY_HOME=/opt/jetty
#JETTY_USER=jetty
#JETTY_PORT=8080
#JETTY_LOGS=/opt/jetty/logs/

#service jetty start
#curl localhost:8080

