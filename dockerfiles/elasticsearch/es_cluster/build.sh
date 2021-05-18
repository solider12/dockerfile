#!/bin/bash
if [ -f "docker-compose.yml" ];then
    docker stop $(docker ps -a | awk '{ print $1}' | tail -n +2)
    docker-compose rm -v
fi
docker-compose up -d
docker exec -itd master /usr/local/es/bin/elasticsearch

