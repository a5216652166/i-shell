#!/bin/sh
#
# hexiaogang@kedacom
#

echo "=================install ================"

#-----HAProxy
tar zxvf haproxy-1.4.18.tar.gz
cd haproxy-1.4.18
make TARGET=linux26 PREFIX=/usr/local/haproxy
make install PREFIX=/usr/local/haproxy
cd ..
\cp haproxy.cfg /usr/local/haproxy/haproxy.cfg

#Æô¶¯HAProxy
#/usr/local/haproxy/sbin/haproxy -f /usr/local/haproxy/haproxy.cfg


echo "=================OK================" 