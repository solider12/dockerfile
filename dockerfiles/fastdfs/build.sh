#!/bin/bash
docker build -f ./dockerfile -t solider12/ubuntu_fastdfs:1.0 .
docker run -d --network=host --name ubuntu_fastdfs -v $PWD/tracker:/home/fastdfs/tracker -v $PWD/storage:/home/fastdfs/storage solider12/ubuntu_fastdfs:1.0
docker exec -it ubuntu_fastdfs bash
#进入命令行 fdfs_upload_file /etc/fdfs/client.conf /usr/local/src/fastdfs-master/COPYING-3_0.txtgroup1/M00/00/00/rBUACmChKcuAaresAACI-zp2apw310.txt
#windows下 http:/yourIP:8888/group1/M00/00/00/rBUACmChKcuAaresAACI-zp2apw310.txt
