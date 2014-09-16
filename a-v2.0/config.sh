#!/bin/sh
#

####NGINX####
NGINX_CONFIG_DIR=/etc/nginx
NGINX_CONFIG_BACKUP_DIR=/etc/nginx.bak
NGINX_CONFIG_FILE=/etc/nginx/nginx.conf
NGINX_SERVER_CONFIG_FILE=/etc/nginx/conf.d/default.conf

# 没备份则备份，有备份则还原
if [ ! -d $NGINX_CONFIG_BACKUP_DIR ]
then
    \cp -av $NGINX_CONFIG_DIR $NGINX_CONFIG_BACKUP_DIR
else
   \cp -av $NGINX_CONFIG_BACKUP_DIR/* $NGINX_CONFIG_DIR
fi

# 行前加sed -i '/http {/i\    server_tokens off;'
# 行后加
sed -i '/http {/a\    server_tokens off;' $NGINX_CONFIG_FILE
# 替换
sed -i '/#gzip  on;/c\    gzip  on;' $NGINX_CONFIG_FILE
# 删除匹配行
sed -i /gzip_types/d $NGINX_CONFIG_FILE
# 行后加
sed -i '/gzip  on;/a\    gzip_types text/plain text/html text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript;' $NGINX_CONFIG_FILE

# 配置/etc/nginx/nginx.conf-->upstream home
sed -i '/gzip/a\    upstream home {'			$NGINX_CONFIG_FILE
sed -i '/upstream home/a\    server 127.0.0.1:8080;'	$NGINX_CONFIG_FILE
sed -i '/upstream home/a\    ip_hash;'			$NGINX_CONFIG_FILE
sed -i '/server 127.0.0.1:8080;/a\    }'		$NGINX_CONFIG_FILE

# 配置/etc/nginx/conf.d/default.conf-->proxy_pass http://home;
sed -i '/\/usr\/share\/nginx\/html/,+1d'			$NGINX_SERVER_CONFIG_FILE
sed -i '/location \/ {/a\        proxy_pass http://home;'	$NGINX_SERVER_CONFIG_FILE


####TOMCAT####
TOMCAT_HTTP_PROT=8080
TOMCAT_CONTEXT_FILE=/etc/tomcat/context.xml
TOMCAT_SERVER_FILE=/etc/tomcat/server.xml

sed -i '/<Context>/c\<Context allowLinking="true">' $TOMCAT_CONTEXT_FILE

sed -i '/<Connector port="8080"/a\               enableLookups="false" ' $TOMCAT_SERVER_FILE
sed -i '/<Connector port="8080"/a\               maxThreads="1024" ' $TOMCAT_SERVER_FILE
sed -i '/<Connector port="8080"/a\               URIEncoding="UTF-8" ' $TOMCAT_SERVER_FILE
sed -i '/<Connector port="8080" protocol="HTTP\/1.1"/c\<Connector port="8080" protocol="HTTP\/1.1"' $TOMCAT_SERVER_FILE
sed -i '/unpackWARs="true" autoDeploy="true"/c\unpackWARs="false" autoDeploy="false">' $TOMCAT_SERVER_FILE


####MYSQL####
MYSQL_CONFIG_FILE=/etc/my.cnf
MYSQL_BAK_CONFIG_FILE=/etc/my.cnf.bak
MYSQL_REMOTE_USERNAME=
MYSQL_REMOTE_PASSWORD=

mysql -uroot -e "GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%' identified by \"repl\";"

if [ ! -f "$MYSQL_BAK_CONFIG_FILE" ]; then
    \cp -av $MYSQL_CONFIG_FILE $MYSQL_BAK_CONFIG_FILE
else
    \cp -av $MYSQL_BAK_CONFIG_FILE $MYSQL_CONFIG_FILE
fi

# Base
sed -i '/\[mysqld\]/a\ skip-name-resolve' $MYSQL_CONFIG_FILE
sed -i '/\[mysqld\]/a\ lower_case_table_names=1' $MYSQL_CONFIG_FILE
sed -i '/\[mysqld\]/a\ innodb_file_per_table ' $MYSQL_CONFIG_FILE
# Replication ignore
sed -i '/\[mysqld\]/a\ binlog-ignore-db=mysql' $MYSQL_CONFIG_FILE
sed -i '/\[mysqld\]/a\ binlog-ignore-db=test' $MYSQL_CONFIG_FILE
sed -i '/\[mysqld\]/a\ binlog-ignore-db=information_schema' $MYSQL_CONFIG_FILE
sed -i '/\[mysqld\]/a\ binlog-ignore-db=performance_schema' $MYSQL_CONFIG_FILE
# Replication Master
sed -i '/\[mysqld\]/a\ log-bin=master-bin.log' $MYSQL_CONFIG_FILE
sed -i '/\[mysqld\]/a\ binlog_format=mixed' $MYSQL_CONFIG_FILE
sed -i '/\[mysqld\]/a\ expire_logs_days = 7' $MYSQL_CONFIG_FILE
sed -i '/\[mysqld\]/a\ max_binlog_size = 128M' $MYSQL_CONFIG_FILE
# Replication Slave
sed -i '/\[mysqld\]/a\ relay-log-index=slave-relay-bin.index' $MYSQL_CONFIG_FILE
sed -i '/\[mysqld\]/a\ relay-log=slave-relay-bin.log' $MYSQL_CONFIG_FILE
# Server ID
sed -i "/\[mysqld\]/a\ server-id=$RANDOM" $MYSQL_CONFIG_FILE
# GTID 复制:http://blog.itpub.net/24945919/viewspace-764369/

#mysql 备份：MariaDB XtraBackup，http://blog.csdn.net/yangzhawen/article/details/30282993 http://www.v2ex.com/t/113430 http://developer.51cto.com/art/201308/406320.htm http://www.tuicool.com/articles/zauqaeN
#http://www.percona.com/doc/percona-xtrabackup/2.2/
#http://www.mike.org.cn/articles/xtrabackup-guide/
#http://www.360doc.com/content/12/1126/09/834950_250260653.shtml
rpm -Uhv http://www.percona.com/downloads/percona-release/percona-release-0.0-1.x86_64.rpm
yum install xtrabackup -y






#TODO:防火墙端口、i-client、i-server
####ISERVER####

####ICLIENT####
