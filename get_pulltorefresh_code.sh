#!/bin/sh
#
#
#
cur_dir=$(cd "$(dirname "$0")"; pwd)

URL=https://github.com/chrisbanes/Android-PullToRefresh
BASE_DIR=/src
SRC_DIR=$BASE_DIR/Android-PullToRefresh

mkdir -p $BASE_DIR

if [ -d "$SRC_DIR" ]; then
    cd $SRC_DIR
    echo "git pull "
    git pull
else
    cd $BASE_DIR
    echo "git clone $URL"
    git clone $URL
fi

cd $cur_dir
