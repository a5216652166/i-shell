#!/bin/sh
#
# 使用前将本目录复制到/soft目录
# 
# xiaojinghai@kedacom

echo "=================install memcached================"
sleep 1
tar xvzf memcached-1.4.7.tar.gz
cd ./memcached-1.4.7
./configure --prefix=/usr/local/memcached --with-libevent=/usr 
make clean
make && make install

#echo "=================reg service================"
#\cp -av ../memcached /etc/init.d/memcached
#chmod 777 /etc/init.d/memcached
#chkconfig --add memcached
#service memcached start

cp -av ./memcached /usr/sbin/
memcached -m 256 -u root -d    -p 11211
memcached -m 256 -u root -d -M -p 11212

echo "=================ok================" 