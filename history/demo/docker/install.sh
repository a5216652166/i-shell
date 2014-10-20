#!/bin/sh
#²Î¿¼£ºhttp://www.widuu.com/chinese_docker/

#yum install docker-io --enablerepo=epel
yum -y install docker-io
service docker start
chkconfig docker on
docker pull centos:latest
docker images centos