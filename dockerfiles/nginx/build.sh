#!/bin/bash
docker build -f ./dockerfile -t solider12/ubuntu_nginx:1.0 .
#docker run -p 3306:3306 -v /usr/local/mydata:/var/lib/mysql -d solider12/ubuntu_mysql:1.0
#docker run -d -p 111.20.72.43:8888:8080 -v /usr/local/webapps:/usr/local/webapps -it --name tomcat77 tomcat:7 bash
#docker run -d -p 3306:3306 --name mysql-single --privileged=true -v=/usr/local/mydata:/var/lib/mysql solider12/ubuntu_mysql:1.0 -it bash /home/login.sh
#docker run -p 3306:3306 --name mysql-single --privileged=true  -v /usr/local/mydata:/var/lib/mysql -d solider12/ubuntu_mysql:1.0
#docker system prune
#docker system prune --volumes
#docker run -itd -p 3306:3306 --name mysql-single solider12/ubuntu_mysql:1.0

rm -rf /data/nginx/conf /data/nginx/html /data/nginx/logs

mkdir -p /data/nginx/{conf,logs}

cp conf/nginx.conf   /data/nginx/conf/

docker run -d -p 80:80 --name ubuntu_nginx -v /data/nginx/conf/nginx.conf:/usr/local/nginx/nginx.conf -v /data/nginx/html:/usr/local/nginx/html -v /data/nginx/logs:/var/log/nginx solider12/ubuntu_nginx:1.0

cp html/index.html /data/nginx/html/

docker exec -it ubuntu_nginx /usr/local/nginx/sbin/nginx -s reload
