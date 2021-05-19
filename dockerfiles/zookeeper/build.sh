#!/bin/bash
docker build -f ./dockerfile -t solider12/ubuntu_zookeeper:1.0 .
docker run -d -p 2181:2181 --name ubuntu_zk -v /usr/local/java8:/usr/local/java8 -v $PWD/data:/usr/local/zookeeper/data -v $PWD/logs:/usr/local/zookeeper/logs solider12/ubuntu_zookeeper:1.0
