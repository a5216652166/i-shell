#!/bin/sh
#yum各种源

#基础工具
service iptables stop
chkconfig iptables off
yum install wget git ntp zip unzip -y
rpm -ivh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
rpm -ivh ftp://ftp.pbone.net/mirror/www.jpackage.org/jpackage/6.0/generic/free/RPMS/jpackage-release-6-3.jpp6.noarch.rpm
rpm -ivh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
rpm -ivh http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
curl https://packagecloud.io/install/repositories/visibilityspots/yum-repo-server/script.rpm | bash
#rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
yum install jpackage-utils yum-priorities -y
yum install goaccess.x86_64 nmon.x86_64 --enablerepo=epel --enablerepo=rpmforge-extras -y
yum install nginx.x86_64 -y
yum install mysql-community-server -y
chkconfig mysqld on
yum install java-1.7.0-openjdk java-1.7.0-openjdk-devel -y
groupadd jetty 
useradd -g jetty jetty
yum install jetty.noarch -y
yum update -y
reboot

yum install ant.noarch
yum install maven3.noarch --skip-broken



#curl http://www.atomicorp.com/installers/atomic | bash



#Fedora源:https://fedoraproject.org/wiki/EPEL/zh-cn
#rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
#rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
#yum install yum-priorities -y

#epel源 http://www.tecmint.com/how-to-enable-epel-repository-for-rhel-centos-6-5/ --enablerepo=epel
#centos7:http://dl.fedoraproject.org/pub/epel/beta/7/x86_64/epel-release-7-0.2.noarch.rpm
#rpm -ivh http://mirrors.ustc.edu.cn/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6

#repoforge源 http://repoforge.org/use/ 使用：--enablerepo=rpmforge-extras
rpm -ivh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm

#jpackage源
rpm -Uvh ftp://ftp.pbone.net/mirror/www.jpackage.org/jpackage/6.0/generic/free/RPMS/jpackage-release-6-3.jpp6.noarch.rpm
yum install jpackage-utils yum-priorities -y

#packagecloud源 jetty-9-1.3
curl https://packagecloud.io/install/repositories/visibilityspots/yum-repo-server/script.rpm | bash

#packagecloud源 jetty-9-1.3
curl https://packagecloud.io/install/repositories/visibilityspots/yum-repo-server/script.rpm | bash
yum install jetty.noarch

#atomic源
wget -q -O - http://www.atomicorp.com/installers/atomic | sh

#Mysql源
rpm -ivh http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
yum install mysql-community-server -y

#Nginx源
rpm -ivh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
yum install nginx

#rpmfusion源 --enablerepo=rpmfusion
#rpm -Uvh http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm 
#rpm -Uvh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm

#tomcat7
rpm -ivh http://mirrors.ustc.edu.cn/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum -y install yum-priorities #这个是jpackage依赖的包要先装                                
rpm -Uvh ftp://ftp.pbone.net/mirror/www.jpackage.org/jpackage/6.0/generic/free/RPMS/jpackage-release-6-3.jpp6.noarch.rpm
yum  install tomcat tomcat-webapps tomcat-admin-webapps tomcat-native java-1.7.0-openjdk-devel  -y

#GVM:Groovy|vert.x|
curl -s get.gvmtool.net | bash
source "/root/.gvm/bin/gvm-init.sh"
gvm version


yum java-1.7.0-openjdk java-1.7.0-openjdk-devel install nginx goaccess mysql-community-server jetty.noarch ant maven nmon.x86_64 --enablerepo=epel --enablerepo=rpmforge-extras -y

yum list goaccess* --enablerepo=epel --enablerepo=rpmforge-extras 

#查看源列表
yum repolist