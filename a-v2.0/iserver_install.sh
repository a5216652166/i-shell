#!/bin/sh
#
set -e
source ./config.conf
cur_dir=$(cd "$(dirname "$0")"; pwd)

## 获取或更新IServer源码
function getIServerCode() {
  mkdir -p $GLOBAL_SOURCECODE_DIR
  if [ ! -d $GLOBAL_SOURCECODE_DIR/i-api ]
  then
    cd $GLOBAL_SOURCECODE_DIR
    git clone https://github.com/ipetty/i-api
  else
    cd $GLOBAL_SOURCECODE_DIR/i-api
    git pull
  fi
  if [ ! -d $GLOBAL_SOURCECODE_DIR/i-server ]
  then
    cd $GLOBAL_SOURCECODE_DIR
    git clone https://github.com/ipetty/i-server
  else
    cd $GLOBAL_SOURCECODE_DIR/i-server
    git pull
  fi
}

## 编译打包IServer
funcion compileIServer(){
  cd $GLOBAL_SOURCECODE_DIR/i-api
  mvn clean install -DskipTests=true 
  cd $GLOBAL_SOURCECODE_DIR/i-server
  mvn clean install -DskipTests=true 
}

getIServerCode
compileIServer
cd $cur_dir