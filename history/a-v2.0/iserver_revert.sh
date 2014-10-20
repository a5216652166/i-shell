#!/bin/sh
#

set -e
source ./config.conf
cur_dir=$(cd "$(dirname "$0")"; pwd)

## ��ԭ
function rollbackIServer(){
  if [ -f "$ISERVER_DEPLOY_BAKUP_DIR/files.zip" ]; then
    rm -rf $ISERVER_UPLOAD_DIR/*
    unzip -oq $ISERVER_DEPLOY_BAKUP_DIR/files.zip -d $ISERVER_UPLOAD_DIR
  fi
  rm -rf $TOMCAT_HOME/webapps/*
  #��ԭӦ�ú������ӹ�ϵ
  unzip -oq $ISERVER_DEPLOY_BAKUP_DIR/webapps.zip -d $TOMCAT_HOME/webapps
  zcat $ISERVER_DEPLOY_BAKUP_DIR/sql.gz | mysql 
  service tomcat restart
}

rollbackIServer
cd $cur_dir