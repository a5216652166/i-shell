#!/bin/sh
#

set -e
source ./config.conf
cur_dir=$(cd "$(dirname "$0")"; pwd)

## »¹Ô­
function rollbackIServer(){
  #if [ -f "$ISERVER_DEPLOY_BAKUP_DIR/files.zip" ]; then
  #  rm -rf $ISERVER_UPLOAD_DIR/*
  #  unzip -oq $ISERVER_DEPLOY_BAKUP_DIR/files.zip -d $ISERVER_UPLOAD_DIR
  #fi
  rm -rf $TOMCAT_HOME/webapps/ROOT/*
  unzip -oq $ISERVER_DEPLOY_BAKUP_DIR/$ISERVER_PAKAGE_NAME -d $TOMCAT_HOME/webapps/ROOT
  ln -sf $ISERVER_UPLOAD_DIR $TOMCAT_HOME/webapps/ROOT
  zcat $ISERVER_DEPLOY_BAKUP_DIR/sql.gz | mysql 
  service tomcat restart
}

rollbackIServer
cd $cur_dir