#!/bin/sh
#
#
#

cur_dir=$(cd "$(dirname "$0")"; pwd)

mkdir -p /src
cd /src/xxyyzz
git pull https://github.com/jinghai/xxyyzz.git master

cd ${cur_dir}