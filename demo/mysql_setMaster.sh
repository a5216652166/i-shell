#!/bin/sh
#

read -p "Master IP:" Master_IP
read -p "Master Admin UserName:"  Master_Admin_UserName
read -p "Master Admin Password:"  Master_Admin_Password

echo "-->Lock Master..."
mysql -h$Master_IP -u$Master_Admin_UserName -p$Master_Admin_Password  -e "FLUSH TABLES WITH READ LOCK;"
echo "-->Get Master Log State..."
mysql -h$Master_IP -u$Master_Admin_UserName -p$Master_Admin_Password  -e "show master status \G;" > masterStatus.txt
LogFile=`grep "File" masterStatus.txt  |awk '{print $2}'`
LogPosition=`grep "Position" masterStatus.txt |awk '{print $2}'`
rm -rf  masterStatus.txt
echo "Dump Master Date..."
#/usr/local/mysql/bin/mysqldump -h$Master_IP -u$Master_Admin_UserName -p$Master_Admin_Password  tso > tso.sql
echo "-->Unlock Master..."
mysql -h$Master_IP -u$Master_Admin_UserName -p$Master_Admin_Password  -e "UNLOCK TABLES;"
echo "-->Master Done"

read -p "Changing Slave's Master,Enter root password of mysql:" password
mysql -uroot -p$password <<EOF
    stop slave;
    change master to master_host='$Master_IP',master_user='repl',master_password='itserver',master_log_file='$LogFile',master_log_pos=$LogPosition;
    -- source tso.sql;   
    start slave;
EOF