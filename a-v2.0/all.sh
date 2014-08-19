#!/bin/sh
#

set -e

service iptables stop
chkconfig iptables off
yum install wget git ntp zip unzip mlocate -y
yum install jpackage-utils yum-priorities -y
rpm -ivh --force http://mirrors.ustc.edu.cn/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
rpm -ivh --force http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
rpm -ivh --force ftp://ftp.pbone.net/mirror/www.jpackage.org/jpackage/6.0/generic/free/RPMS/jpackage-release-6-3.jpp6.noarch.rpm
rpm -ivh --force http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
rpm -ivh --force http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
#JVM:
yum install java-1.7.0-openjdk java-1.7.0-openjdk-devel -y
#Tomcat:/usr/share/tomcat7/
#TODO:Edit /etc/yum.conf replace gpgcheck=1 to gpgcheck=0
yum install tomcat tomcat-webapps tomcat-admin-webapps tomcat-native -y
yum install goaccess.x86_64 nmon.x86_64 --enablerepo=epel --enablerepo=rpmforge-extras -y
yum install nginx -y
yum install mysql-community-server -y
chkconfig mysqld on
yum install ant
#maven:/usr/share/apache-maven/
yum install apache-maven
curl -s get.gvmtool.net | bash
source "/root/.gvm/bin/gvm-init.sh"
gvm version
yum repolist
yum makecache
yum update -y
reboot



#curl https://packagecloud.io/install/repositories/visibilityspots/yum-repo-server/script.rpm | bash
#groupadd jetty 
#useradd -g jetty jetty
#yum install jetty.noarch -y