#!/bin/bash
cp -r /home/redis-5.0.10  /usr/local/ && \
mv /usr/local/redis-5.0.10 /usr/local/redis && \
rm -rf /home/redis-5.0.10
