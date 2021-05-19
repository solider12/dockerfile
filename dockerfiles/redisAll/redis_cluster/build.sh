#!/bin/bash
if [ -f "docker-compose.yml" ];then
    docker stop $(docker ps -a | awk '{ print $1}' | tail -n +2)
    docker-compose rm -v
fi
docker-compose up -d
cd ..
cd redis-cli
./build.sh
docker run --rm -it solider12/redis-cli /usr/local/redis/bin/redis-cli --cluster create yourIP:6061 yourIP:6062 yourIP:6063 yourIP:6064 yourIP:6065 yourIP:6066 -a 1234 --cluster-replicas 1
docker exec -it redis-6061 /usr/local/redis/bin/redis-cli -h 152.136.111.66 -p 6061 -a 1234 -c


