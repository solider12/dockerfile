#!/bin/bash
docker build -f ./dockerfile -t solider12/ubuntu_rabbitmq:1.0 .
docker run -d -p 5672:5672 -p 15672:15672 --name ubuntu_rq  solider12/ubuntu_rabbitmq:1.0
