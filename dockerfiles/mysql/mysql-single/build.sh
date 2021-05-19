#!/bin/bash
docker build -f ./dockerfile -t solider12/ubuntu_mysql:1.0 .
#docker run -p 3306:3306 -v /usr/local/mydata:/var/lib/mysql -d solider12/ubuntu_mysql:1.0
#docker run -d -p 111.20.72.43:8888:8080 -v /usr/local/webapps:/usr/local/webapps -it --name tomcat77 tomcat:7 bash
#docker run -d -p 3306:3306 --name mysql-single --privileged=true -v=/usr/local/mydata:/var/lib/mysql solider12/ubuntu_mysql:1.0 -it bash /home/login.sh
#docker run -p 3306:3306 --name mysql-single --privileged=true  -v /usr/local/mydata:/var/lib/mysql -d solider12/ubuntu_mysql:1.0
#docker system prune
#docker system prune --volumes
#docker run -itd -p 3306:3306 --name mysql-single solider12/ubuntu_mysql:1.0
docker run --privileged=true -p 3306:3306 --name mysql-single -v /usr/local/mydata:/var/lib/mysql -v $PWD/mysqld.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf -e MYSQL_ROOT_PASSWORD=12345678 -d solider12/ubuntu_mysql:1.0

#docker run --name test3_mysql -v test3_mysql:/var/lib/mysql -d -e MYSQL_ROOT_PASSWORD=password mysql:5.7
#docker exec -it mysql-single  /bin/bash /home/login.sh
#docker run --name mysql-single -d -p 3306:3306 -it solider12/ubuntu_mysql:1.0
docker exec -it mysql-single mysql -uroot -h localhost -p
#docker exec -it mysql-single /bin/bash

