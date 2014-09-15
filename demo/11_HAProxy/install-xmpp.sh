#!/bin/sh
#
# hexiaogang@kedacom
#

echo "=================install ================"

#���밲װ-HAProxy
tar zxvf haproxy-1.4.18.tar.gz
cd haproxy-1.4.18
make TARGET=linux26 PREFIX=/usr/local/haproxy
make install PREFIX=/usr/local/haproxy
cd ..
\cp haproxy-xmpp.cfg /usr/local/haproxy/haproxy.cfg

#ע�����
\cp haproxy /etc/rc.d/init.d/
chmod 777 /etc/rc.d/init.d/haproxy
chkconfig --add haproxy
chkconfig haproxy on

#����HAProxy
service haproxy start

#����HAProxy
#/usr/local/haproxy/sbin/haproxy -f /usr/local/haproxy/haproxy.cfg
#��������
#echo "" >> /etc/rc.d/rc.local
#echo "/usr/local/haproxy/sbin/haproxy -f /usr/local/haproxy/haproxy.cfg" >> /etc/rc.d/rc.local

echo "=================OK================" 