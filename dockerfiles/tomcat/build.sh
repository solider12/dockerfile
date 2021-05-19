#!/bin/bash
rm -rf /usr/local/tomcat

mkdir -p /usr/local/tomcat/webapps

docker build -f ./dockerfile -t solider12/ubuntu_tomcat:1.0 .

#docker run -p 3306:3306 -v /usr/local/mydata:/var/lib/mysql -d solider12/ubuntu_mysql:1.0
#docker run -d -p 111.20.72.43:8888:8080 -v /usr/local/webapps:/usr/local/webapps -it --name tomcat77 tomcat:7 bash
#docker run -d -p 3306:3306 --name mysql-single --privileged=true -v=/usr/local/mydata:/var/lib/mysql solider12/ubuntu_mysql:1.0 -it bash /home/login.sh
#docker run -p 3306:3306 --name mysql-single --privileged=true  -v /usr/local/mydata:/var/lib/mysql -d solider12/ubuntu_mysql:1.0
#docker system prune
#docker system prune --volumes
#docker run -itd -p 3306:3306 --name mysql-single solider12/ubuntu_mysql:1.0

docker run -d -p 8080:8080 --name ubuntu_tomcat --privileged=true -v /usr/local/java8:/usr/local/java8 -v /usr/local/tomcat/logs:/usr/local/tomcat/logs -v /usr/local/tomcat/webapps:/usr/local/tomcat/webapps solider12/ubuntu_tomcat:1.0

docker exec ubuntu_tomcat cp -r /usr/local/tomcat/webapps_dist/. /usr/local/tomcat/webapps/
