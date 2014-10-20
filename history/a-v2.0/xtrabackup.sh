#!/bin/sh
#

set -e
source ./config.conf
cur_dir=$(cd "$(dirname "$0")"; pwd)

#mysql 备份：MariaDB XtraBackup，http://blog.csdn.net/yangzhawen/article/details/30282993 http://www.v2ex.com/t/113430 http://developer.51cto.com/art/201308/406320.htm http://www.tuicool.com/articles/zauqaeN
#http://www.percona.com/doc/percona-xtrabackup/2.2/
#http://www.mike.org.cn/articles/xtrabackup-guide/
#http://www.360doc.com/content/12/1126/09/834950_250260653.shtml
#https://github.com/sixninetynine/surrogate
#rpm -Uhv http://www.percona.com/downloads/percona-release/percona-release-0.0-1.x86_64.rpm
#yum install xtrabackup -y
#innobackupex说明：http://blog.csdn.net/dbanote/article/details/13295727
#全备（/backup/mysql/data/2014-09-09_19-01-35）:innobackupex  /data/backups/daily/Tuesday/full-2014-09-09_2024
#增量备:innobackupex --user=root --password=*** --incremental-basedir=/backup/mysql/data/2013-10-29_09-05-25 --incremental /backup/mysql/data  
#git clone https://github.com/jinghai/surrogate
#./surrogate/installer.sh <<-EOF
#EOF
#echo "" > /var/spool/cron/root

cd $cur_dir

