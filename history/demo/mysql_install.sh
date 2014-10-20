#!/bin/sh
#

#install mysql

groupadd mysql
useradd -r -g mysql mysql

tar zxvf mysql-5.5.25-linux2.6-x86_64.tar.gz
mv  mysql-5.5.25-linux2.6-x86_64  /usr/local/
mv  /usr/local/mysql-5.5.25-linux2.6-x86_64 /usr/local/mysql
\cp ./my.cnf /etc/my.cnf

cd /usr/local/mysql
chown -R mysql .
chgrp -R mysql .
scripts/mysql_install_db --user=mysql 
chown -R root .
chown -R mysql data

#bin/mysqld_safe --user=mysql &
\cp support-files/mysql.server /etc/init.d/mysqld
chmod +x /etc/init.d/mysqld
chkconfig --add mysqld
chkconfig mysqld on
service mysqld start

ln -s /usr/local/mysql/bin/mysql /sbin/mysql 
ln -s /usr/local/mysql/bin/mysqldump /sbin/mysqldump 
ln -s /usr/local/mysql/bin/mysqladmin /sbin/mysqladmin 

cd  -
\cp -av setMaster.sh  /usr/local/mysql/bin/
\cp -av mysql_master_chk.sh  /usr/sbin/
\cp -av mysql_slave_chk.sh   /usr/sbin/
chmod 700  /usr/local/mysql/bin/setMaster.sh
chmod 700 /usr/sbin/mysql_master_chk.sh
chmod 700 /usr/sbin/mysql_slave_chk.sh

#init mysql users
mysql -uroot -e "GRANT all on *.* to 'admin'@'%' identified by \"itserver\";"
mysql -uroot -e "GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%' identified by \"itserver\";"
mysql -uroot -e "INSTALL PLUGIN rpl_semi_sync_master SONAME 'semisync_master.so';"
mysql -uroot -e "INSTALL PLUGIN rpl_semi_sync_slave SONAME 'semisync_slave.so';"
mysql -uroot  -e "delete from mysql.user where user='';"
mysql -uroot  -e "flush privileges;"
mysqladmin -uroot password "itserver"
mysql -uroot -pitserver  -e "delete from mysql.user where password='';"
service mysqld restart

#Backup data
mkdir -p /data
cp -av ./backup_mysql.sh  /usr/sbin/
chmod +x /usr/sbin/backup_mysql.sh
grep -q "\/usr\/sbin\/backup_mysql.sh" /var/spool/cron/root &&{
    echo "Backup mysql cron has been setted."
}||{
    echo "10 1 * * * /usr/sbin/backup_mysql.sh" >>/var/spool/cron/root
}
service crond restart