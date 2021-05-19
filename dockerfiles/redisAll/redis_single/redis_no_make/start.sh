#!/bin/bash
docker run -itd -p 6379:6379 solider12/ubuntu_redis:1.0
docker ps -a
docker exec -it 容器id /bin/bash


