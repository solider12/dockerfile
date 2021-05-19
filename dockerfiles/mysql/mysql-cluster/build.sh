#!/bin/bash
# 获取服务器的ip
docker-ip() 
{
  docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$@"
}


if [ -d "./master/data" ];then
docker rm -f mysql-master mysql-slave
rm -rf ./master/data/* ./slave/data/*
fi

docker-compose up -d
echo "test start"
docker exec -it mysql-master bash -c "mysql_config_editor set --login-path=client --user=root --port=3307 --socket=/var/run/mysqld/mysqld.sock --password"
docker exec -it mysql-slave  bash -c "mysql_config_editor set --login-path=client --user=root --port=3308 --socket=/var/run/mysqld/mysqld.sock --password"
docker exec mysql-master bash -c "mysql --login-path=client -e \"create user repl;GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%' IDENTIFIED BY 'repl';FLUSH PRIVILEGES;\""
MS_STATUS=`docker exec mysql-master bash -c "mysql --login-path=client -e \"SHOW MASTER STATUS;\""`
CURRENT_LOG=`echo $MS_STATUS | awk '{print $6}'`
CURRENT_POS=`echo $MS_STATUS | awk '{print $7}'`
echo $CURRENT_LOG
echo $CURRENT_POS 
start_slave_stmt="CHANGE MASTER TO 
                  MASTER_HOST='$(docker-ip mysql-master)',
		  MASTER_USER='repl',
		  MASTER_PASSWORD='repl',
		  MASTER_LOG_FILE='$CURRENT_LOG',
		  MASTER_LOG_POS=$CURRENT_POS;"
start_slave_cmd='mysql --login-path=client -e "'
start_slave_cmd+="$start_slave_stmt"
start_slave_cmd+='START SLAVE;"'
echo $start_slave_cmd
docker exec mysql-slave bash -c "$start_slave_cmd"
docker exec mysql-slave bash -c "mysql --login-path=client -e \"SHOW SLAVE STATUS \G;\""
docker exec mysql-master bash -c "mysql --login-path=client -e \"create database test;\""
MS_DB=`docker exec mysql-slave bash -c "mysql --login-path=client -e \"show databases;\""`
echo $MS_DB
docker exec -it mysql-slave bash
echo "test end"
