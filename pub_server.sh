#!/bin/sh
#
#
#发布Server API
cur_dir=$(cd "$(dirname "$0")"; pwd)
tomcat_home=/opt/apache-tomcat-7.0.54
backup_dir=/home/backup/server
mkdir -p $backup_dir
lock_file=$backup_dir/pub_server.lock


if [ -f "$lock_file" ]; then
    echo "this operate was locked,please run pub_server_unlock.sh first."
    exit  0
fi

service tomcat stop

echo "" >$lock_file

./pub_server_backup.sh

cd /src/i-api
mvn clean install -DskipTests=true 

cd /src/i-server
mvn clean install -DskipTests=true 


rm -rf $tomcat_home/webapps/ROOT/*
rm -rf $tomcat_home/logs/*
rm -rf $tomcat_home/work/*

\cp -a /src/i-server/target/ipetty-server.war /src/i-server/target/ROOT.war
unzip -oq /src/i-server/target/ROOT.war -d $tomcat_home/webapps/ROOT

sed -i "/^jdbc.username=/c\jdbc.username=admin" $tomcat_home/webapps/ROOT/WEB-INF/classes/jdbc.properties
sed -i "/^jdbc.password=/c\jdbc.password=itserver" $tomcat_home/webapps/ROOT/WEB-INF/classes/jdbc.properties

mkdir -p /home/data/files
ln -sf /home/data/files $tomcat_home/webapps/ROOT

mysql -pitserver -e "create database if not exists ipetty default charset utf8;"

service tomcat start

cd ${cur_dir}
#tail -f $tomcat_home/logs/catalina.out
echo "===========ok==========="