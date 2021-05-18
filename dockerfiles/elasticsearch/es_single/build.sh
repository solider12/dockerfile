#!/bin/bash
chmod 777 es_config.sh
./es_config.sh
docker build -f ./dockerfile -t solider12/ubuntu_es:1.0 .
#docker run -e ES_JAVA_OPTS="-Xms256m -Xmx256m" -e “discovery.type=single-node” -d  -p 9202:9202 -v /usr/local/java8:/usr/local/java8 --name es-single  --ip 152.136.111.66 --hostname=es-single  solider12/ubuntu_es:1.0
#docker run -e ES_JAVA_OPTS="-Xms256m -Xmx256m" -e “discovery.type=single-node” -d  -p 9202:9202 -v /usr/local/java8:/usr/local/java8 -v $(pwd)/es.yml:/usr/local/es/config/elasticsearch.yml --name es-single solider12/ubuntu_es:1.0

