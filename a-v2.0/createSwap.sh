#!/bin/sh
#
set -e

cur_dir=$(cd "$(dirname "$0")"; pwd)

# 创建分区文件
# count=SIZE*1024  (size以MB为单位），以下是2G
dd if=/dev/zero of=/swap bs=1024 count=2097152

# 格式划分区文件
mkswap /swap 

# 启用分区
# 停用分区-->swapoff /swap
swapon /swap

# 开机自动加载
echo '/swap swap swap default 0 0' >> /etc/fstab

cd $cur_dir

