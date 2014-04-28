#!/bin/sh
#
#
#
cur_dir=$(cd "$(dirname "$0")"; pwd)

mkdir -p /src
rm -rf /src/*
cd /src
git clone https://github.com/jinghai/xxyyzz

cd ${cur_dir}