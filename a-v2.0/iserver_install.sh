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
  #backup
  mkdir -p $ISERVER_DEPLOY_BAKUP_DIR
  rm -rf $ISERVER_DEPLOY_BAKUP_DIR/*
  mkdir -p $ISERVER_UPLOAD_DIR
  \cp -av $GLOBAL_SOURCECODE_DIR/$ISERVER_PROJECT_NAME/target/$ISERVER_PAKAGE_NAME $ISERVER_DEPLOY_BAKUP_DIR/
  mysqldump --all-databases |gzip>$ISERVER_DEPLOY_BAKUP_DIR/sql.gz
  zip -r $ISERVER_DEPLOY_BAKUP_DIR/files.zip $ISERVER_UPLOAD_DIR/

  #deploy
  rm -rf $TOMCAT_HOME/webapps/ROOT/*
  unzip -oq $GLOBAL_SOURCECODE_DIR/$ISERVER_PROJECT_NAME/target/$ISERVER_PAKAGE_NAME -d $TOMCAT_HOME/webapps/ROOT
  sed -i "/^jdbc.username=/c\jdbc.username=root" $TOMCAT_HOME/webapps/ROOT/WEB-INF/classes/jdbc.properties
  sed -i "/^jdbc.password=/c\jdbc.password=" $TOMCAT_HOME/webapps/ROOT/WEB-INF/classes/jdbc.properties
  mkdir -p $ISERVER_UPLOAD_DIR
  ln -sf $ISERVER_UPLOAD_DIR $TOMCAT_HOME/webapps/ROOT
  mysql -e "create database if not exists ipetty default charset utf8;"
  service tomcat restart
}

## 还原
function rollbackIServer(){
  rm -rf $ISERVER_UPLOAD_DIR/*
  unzip -oq $ISERVER_DEPLOY_BAKUP_DIR/files.zip -d $ISERVER_UPLOAD_DIR
  rm -rf $TOMCAT_HOME/webapps/ROOT/*
  unzip -oq $ISERVER_DEPLOY_BAKUP_DIR/$ISERVER_PAKAGE_NAME -d $TOMCAT_HOME/webapps/ROOT
  ln -sf $ISERVER_UPLOAD_DIR $TOMCAT_HOME/webapps/ROOT
  zcat $ISERVER_DEPLOY_BAKUP_DIR/sql.gz | mysql 
  service tomcat restart
}

getIServerCode
compileIServer
deployIServer
cd $cur_dir