#!/bin/bash
if [ -f "docker-compose.yml" ];then
rm -rf docker-compose.yml
fi
touch docker-compose.yml
echo 'version: "3.8"' >> docker-compose.yml
echo 'services:' >> docker-compose.yml

for port in `seq 6061 6066`; do \
  if [ -d "${port}" ];then
       rm -rf ${port}
  fi    
  mkdir -p ${port}/conf \
  && PORT=${port} envsubst < redis-cluster.tmpl > ${port}/conf/redis.conf \
  && mkdir -p ${port}/data \
  && PORT=${port} envsubst < redis-compose-item.tmpl > temp.txt \
  && value=$(<temp.txt) \
  && echo "$value" >> docker-compose.yml \
  && rm -rf temp.txt 
done