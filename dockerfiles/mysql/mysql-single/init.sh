#!/bin/bash
set -m
set -e

function mysql_init()
{
# mysql -uroot -e "create user 'debian-sys-maint'@'localhost' identified by '$passwd';GRANT ALL PRIVILEGES ON *.* TO 'debian-sys-maint'@'localhost' WITH GRANT OPTION;FLUSH PRIVILEGES;GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;alter user 'root'@'localhost' identified by '12345678';FLUSH PRIVILEGES;"

/etc/init.d/mysql stop
usermod -d /var/lib/mysql/ mysql
/etc/init.d/mysql start
cat /etc/mysql/debian.cnf
str=$(awk '/password/{print NR}' /etc/mysql/debian.cnf)
arr=(${str// / })
lno=${arr[0]}
line=$(awk "NR==${lno}{print}" /etc/mysql/debian.cnf)
arr2=(${line//=/ })
temp=${arr2[1]}
passwd=${temp}
echo $passwd
mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'debian-sys-maint'@'localhost' IDENTIFIED BY '$passwd' WITH GRANT OPTION;FLUSH PRIVILEGES;update mysql.user set host = '%' where user = 'root';FLUSH PRIVILEGES;GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;flush privileges;alter user 'root'@'%' identified by '12345678';flush privileges;ALTER USER 'root'@'%' IDENTIFIED BY '12345678' PASSWORD EXPIRE NEVER;alter user 'root'@'%' identified with mysql_native_password by '12345678';FLUSH PRIVILEGES;"
tail -F /var/log/mysql/error.log &
/etc/init.d/mysql restart
tail -F /var/log/mysql/error.log &
}

rm -rf /var/lib/mysql/*
echo "=============================="
echo "=      Setting up MySQL      ="
echo "=============================="

# Initialize MySQL installation
mysqld --initialize-insecure > /dev/null 2>&1
tail -F /var/log/mysql/error.log &
echo "=============================="
echo "=       Starting MySQL       ="
echo "=============================="

#exec  mysqld_safe > /dev/null 2>&1 &
#tail -F /var/log/mysql/error.log &

echo "=============================="
echo "=      Waiting for MySQL     ="
echo "=============================="

echo "=============================="
echo "=      Initiating MySQL      ="
echo "=============================="
mysql_init
echo "=============================="
echo "=        Ready to Use!       ="
echo "=============================="
fg
