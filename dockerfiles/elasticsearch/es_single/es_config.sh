#!/bin/bash
if [ ! -f "elasticsearch-7.9.1-linux-x86_64.tar.gz" ]; then
   exit 0
fi	

if [ ! -d "elasticsearch-7.9.1" ]; then
mkdir -p es_outer
tar -xzf elasticsearch-7.9.1-linux-x86_64.tar.gz -C es_outer
rm -rf es_outer/elasticsearch-7.9.1/jdk
#/bin/cp -rf elasticsearch.yml es_outer/elasticsearch-7.9.1/config/
rm -rf es_outer/elasticsearch-7.9.1/config/elasticsearch.yml
sed -i '14r env.txt' es_outer/elasticsearch-7.9.1/bin/elasticsearch
mv es_outer/elasticsearch-7.9.1 es_outer/es
rm -rf elasticsearch-7.9.1-linux-x86_64.tar.gz
fi
