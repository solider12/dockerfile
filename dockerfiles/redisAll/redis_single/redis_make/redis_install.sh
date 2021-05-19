#!/bin/bash
apt-get update && \
apt-get install -y gcc make && \
cd /home/redis-5.0.10 && \
make && make PREFIX=/usr/local/redis install && \
mkdir -p /usr/local/redis/conf/ && \
cp /home/redis-5.0.10/redis.conf  /usr/local/redis/bin/ && \
sed -i '136s/daemonize no/daemonize yes/' /usr/local/redis/bin/redis.conf && \
rm -rf /home/redis-5.0.10 && \
apt-get --purge remove -y gcc make

