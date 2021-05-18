#!/bin/bash
ulimit -n 4096 && \
groupadd esuser && \
useradd esuser -g esuser && \
chown -R esuser:esuser /var/log/* && \
chown -R esuser:esuser /var/lib/* && \
chmod -R 777 /usr/local/es && \
chmod -R 777 /var/log && \
chmod -R 777 /var/lib && \
apt-get autoclean && \
apt-get clean && \
apt-get autoremove
