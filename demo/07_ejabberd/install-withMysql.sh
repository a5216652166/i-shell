#!/bin/sh
#
# xiaojinghai@kedacom
#

echo "=================install ================"

#安装
./ejabberd-2.1.9-linux-x86_64-installer.bin
#开机启动
echo "" >> /etc/rc.d/rc.local
echo "/opt/ejabberd-2.1.9/bin/ejabberdctl start" >> /etc/rc.d/rc.local

mysql -uroot -pitserver -e "create database ejabberd CHARACTER SET utf8 COLLATE utf8_general_ci;"
#mysql -u root -pitserver ejabberd</opt/ejabberd-2.1.9/lib/ejabberd-2.1.9/priv/odbc/mysql.sql
mysql -u root -pitserver ejabberd</soft/09_ejabberd/mysql.sql


echo "=================OK================" 