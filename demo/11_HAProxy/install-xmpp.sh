#!/bin/sh
#
# hexiaogang@kedacom
#

echo "=================install ================"

#编译安装-HAProxy
tar zxvf haproxy-1.4.18.tar.gz
cd haproxy-1.4.18
make TARGET=linux26 PREFIX=/usr/local/haproxy
make install PREFIX=/usr/local/haproxy
cd ..
\cp haproxy-xmpp.cfg /usr/local/haproxy/haproxy.cfg

#注册服务
\cp haproxy /etc/rc.d/init.d/
chmod 777 /etc/rc.d/init.d/haproxy
chkconfig --add haproxy
chkconfig haproxy on

#启动HAProxy
service haproxy start

#启动HAProxy
#/usr/local/haproxy/sbin/haproxy -f /usr/local/haproxy/haproxy.cfg
#开机启动
#echo "" >> /etc/rc.d/rc.local
#echo "/usr/local/haproxy/sbin/haproxy -f /usr/local/haproxy/haproxy.cfg" >> /etc/rc.d/rc.local

echo "=================OK================" 