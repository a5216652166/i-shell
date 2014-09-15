#!/bin/sh
#

####NGINX####
## nginx����Ŀ¼
NGINX_CONFIG_DIR=/etc/nginx

## nginx���ñ���Ŀ¼
NGINX_CONFIG_BACKUP_DIR=/etc/nginx.bak

## nginx�����ļ�
NGINX_CONFIG_FILE=/etc/nginx/nginx.conf

## nginx server �����ļ�
NGINX_SERVER_CONFIG_FILE=/etc/nginx/conf.d/default.conf

# û�����򱸷ݣ��б�����ԭ
if [ -d $NGINX_CONFIG_BACKUP_DIR ]
then
  \cp -av $NGINX_CONFIG_BACKUP_DIR/* $NGINX_CONFIG_DIR
else
   \cp -av $NGINX_CONFIG_DIR $NGINX_CONFIG_BACKUP_DIR
fi

#��ǰ��sed -i '/http {/i\    server_tokens off;'
#�к��
sed -i '/http {/a\    server_tokens off;' $NGINX_CONFIG_FILE
#�滻
sed -i '/#gzip  on;/c\    gzip  on;' $NGINX_CONFIG_FILE
#ɾ��ƥ����
sed -i /gzip_types/d $NGINX_CONFIG_FILE
#�к��
sed -i '/gzip  on;/a\    gzip_types text/plain text/html text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript;' $NGINX_CONFIG_FILE

#########��������û��ͨ��#########
sed -i '/server_name/a\    upstream home {' /etc/nginx/conf.d/default.conf
sed -i '/upstream home/a\    server 127.0.0.1:8080;' /etc/nginx/conf.d/default.conf
sed -i '/upstream home/a\    sticky;' /etc/nginx/conf.d/default.conf
sed -i '/server 127.0.0.1:8080;/a\    }' /etc/nginx/conf.d/default.conf

location / {
    proxy_pass http://home;
    health_check;
}

cp ./logrotate/nginx	/etc/logrotate.d/
service crond restart


####TOMCAT####
TOMCAT_HTTP_PROT=8080

sed -i '/<Context>/c\<Context allowLinking="true">' $CATALINA_HOME/conf/context.xml
sed -i '/<Connector port="8080"/a\ enableLookups="false" ' $CATALINA_HOME/conf/server.xml
sed -i '/<Connector port="8080"/a\ maxThreads="1024" ' $CATALINA_HOME/conf/server.xml
sed -i '/<Connector port="8080"/a\ URIEncoding="UTF-8" ' $CATALINA_HOME/conf/server.xml
#sed -i '/<Connector port="8080" protocol="HTTP\/1.1"/c\<Connector port="80" protocol="HTTP\/1.1"' $CATALINA_HOME/conf/server.xml
sed -i '/unpackWARs="true" autoDeploy="true"/c\unpackWARs="false" autoDeploy="false">' $CATALINA_HOME/conf/server.xml

####MYSQL####
MYSQL_REMOTE_USERNAME=
MYSQL_REMOTE_PASSWORD=

####ISERVER####

####ICLIENT####