#!/bin/sh
#
set -e

cur_dir=$(cd "$(dirname "$0")"; pwd)

# ���������ļ�
# count=SIZE*1024  (size��MBΪ��λ����������2G
dd if=/dev/zero of=/swap bs=1024 count=2097152

# ��ʽ�������ļ�
mkswap /swap 

# ���÷���
# ͣ�÷���-->swapoff /swap
swapon /swap

# �����Զ�����
echo '/swap swap swap default 0 0' >> /etc/fstab

cd $cur_dir

