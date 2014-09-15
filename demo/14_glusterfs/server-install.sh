#!/bin/sh
#
# chenyongkang@kedacom.com
#

echo "===============install fuse=============="
tar zvxf fuse-2.8.0.tar.gz
cd fuse-2.8.0
./configure --enable-dependency-tracking --enable-lib --enable-util
make
make install
cd ../


echo "============install glusterfs============"

#create share point
mkdir -p /home/glusterfs
chmod 1777 /home/glusterfs

tar zvxf glusterfs-3.0.3.tar.gz
cd glusterfs-3.0.3
./configure --enable-fusermount
make
make install
cd ../

#start glusterfs server
cp -av ./glusterfsd.vol /usr/local/etc/glusterfs/
glusterfsd -l /var/log/glusterfs.log -f /usr/local/etc/glusterfs/glusterfsd.vol

#start when power on
echo "#start glusterfs server" >> /etc/rc.d/rc.local
echo "glusterfsd -l /var/log/glusterfs.log -f /usr/local/etc/glusterfs/glusterfsd.vol" >> /etc/rc.d/rc.local

echo "=================OK===================" 