#!/bin/sh
#
set -e
source ./config.conf
cur_dir=$(cd "$(dirname "$0")"; pwd)

## 更新
function getIServerCode() {
  mkdir -p $GLOBAL_SOURCECODE_DIR
  if [ ! -d $GLOBAL_SOURCECODE_DIR/$IAPI_PROJECT_NAME ]
  then
    cd $GLOBAL_SOURCECODE_DIR
    git clone https://github.com/ipetty/i-api
  else
    cd $GLOBAL_SOURCECODE_DIR/$IAPI_PROJECT_NAME
    git pull
  fi
  if [ ! -d $GLOBAL_SOURCECODE_DIR/$ISERVER_PROJECT_NAME ]
  then
    cd $GLOBAL_SOURCECODE_DIR
    git clone https://github.com/ipetty/i-server
  else
    cd $GLOBAL_SOURCECODE_DIR/$ISERVER_PROJECT_NAME
    git pull
  fi
}
## 编译
function compileIServer(){
  cd $GLOBAL_SOURCECODE_DIR/$IAPI_PROJECT_NAME
  mvn clean install -DskipTests=true 
  cd $GLOBAL_SOURCECODE_DIR/$ISERVER_PROJECT_NAME
  mvn clean install -DskipTests=true 
}
## 部署
function deployIServer(){
  #备份应用、附件、数据库
  mkdir -p $ISERVER_DEPLOY_BAKUP_DIR
  rm -rf $ISERVER_DEPLOY_BAKUP_DIR/*
  mkdir -p $ISERVER_UPLOAD_DIR

  mysqldump --all-databases |gzip>$ISERVER_DEPLOY_BAKUP_DIR/sql.gz

  cd $ISERVER_UPLOAD_DIR
  set +e
  zip -r9 $ISERVER_DEPLOY_BAKUP_DIR/files.zip *
  set -e

  cd $TOMCAT_HOME/webapps
  #只备份应用和软连接关系
  zip -ry9 $ISERVER_DEPLOY_BAKUP_DIR/webapps.zip *

  #部署
  rm -rf $TOMCAT_HOME/webapps/ROOT/*
  unzip -oq $GLOBAL_SOURCECODE_DIR/$ISERVER_PROJECT_NAME/target/$ISERVER_PAKAGE_NAME -d $TOMCAT_HOME/webapps/ROOT
  sed -i "/^jdbc.username=/c\jdbc.username=root" $TOMCAT_HOME/webapps/ROOT/WEB-INF/classes/jdbc.properties
  sed -i "/^jdbc.password=/c\jdbc.password=" $TOMCAT_HOME/webapps/ROOT/WEB-INF/classes/jdbc.properties
  mkdir -p $ISERVER_UPLOAD_DIR
  ln -sf $ISERVER_UPLOAD_DIR $TOMCAT_HOME/webapps/ROOT
  mysql -e "create database if not exists ipetty default charset utf8;"
  service tomcat restart
}


getIServerCode
compileIServer
deployIServer
cd $cur_dir