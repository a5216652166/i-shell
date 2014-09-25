#!/bin/sh
#
set -e
source ./config.conf

function getSourceCode() {
  cur_dir=$(cd "$(dirname "$0")"; pwd)
  cd $GLOBAL_SOURCECODE_DIR
  git clone https://github.com/ipetty/i-api
  git clone https://github.com/ipetty/i-server
  cd $cur_dir
}

