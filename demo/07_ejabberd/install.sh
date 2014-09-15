#!/bin/sh
#
# xiaojinghai@kedacom
#

echo "=================install ================"

#安装
./ejabberd-2.1.10-linux-x86_64-installer.bin
#开机启动
echo "" >> /etc/rc.d/rc.local
echo "/opt/ejabberd-2.1.10/bin/ejabberdctl start" >> /etc/rc.d/rc.local
/opt/ejabberd-2.1.10/bin/ejabberdctl start

#multicast插件
\cp -av ./mod_multicast.beam /opt/ejabberd-2.1.10/lib/ejabberd-2.1.10/ebin/
\cp -av ./ejabberd_router_multicast.beam /opt/ejabberd-2.1.10/lib/ejabberd-2.1.10/ebin/

echo "=================OK================" 