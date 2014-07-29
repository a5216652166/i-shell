#!/bin/sh
#
#
#安装Jetty
echo "正在安装Jetty..."

if [ ! -f "/download/jetty-distribution-9.1.2.v20140210.tar.gz" ]; then
    wget -P /download  "http://eclipse.org/downloads/download.php?file=/jetty/stable-9/dist/jetty-distribution-9.1.2.v20140210.tar.gz"
fi
#sudo wget  -O jetty.tar.gz
#tar -xf jetty.tar.gz

#rm -rf jetty.tar.gz
#mv jetty-* jetty

#sudo /usr/sbin/useradd jetty
#sudo mv jetty /srv/

#sudo chown -R jetty:jetty /srv/jetty
#sudo ln -s /srv/jetty/bin/jetty.sh /etc/init.d/jetty
#sudo /sbin/chkconfig --add jetty
#sudo /sbin/chkconfig jetty on

#sudo vi /etc/init.d/jetty

#add after comments
#JETTY_HOME=/srv/jetty
#JETTY_USER=jetty
#JETTY_PORT=8080
#JETTY_LOGS=/srv/jetty/logs/
#sudo mkdir -p /srv/logs
#sudo chown -R jetty:jetty /srv/logs

#sudo /sbin/service jetty start
#curl http://localhost:8080
#sudo /sbin/iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080

echo "===========Jetty ok==========="