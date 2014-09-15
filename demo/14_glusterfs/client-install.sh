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
tar zvxf glusterfs-3.0.3.tar.gz
cd glusterfs-3.0.3
./configure --enable-fusermount
make
make install
cd ../

#start glusterfs client
cp -av ./glusterfs.vol /usr/local/etc/glusterfs/
modprobe fuse
glusterfs -l /var/log/glusterfs.log -f /usr/local/etc/glusterfs/glusterfs.vol

#start when power on
echo "#start glusterfs client" >> /etc/rc.d/rc.local
echo "glusterfs -l /var/log/glusterfs.log -f /usr/local/etc/glusterfs/glusterfs.vol" >> /etc/rc.d/rc.local

echo "=================OK===================" 