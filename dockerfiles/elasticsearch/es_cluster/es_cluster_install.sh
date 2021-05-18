#!/bin/bash
ip=[yourIp]
MasterNameArr=()
NodeAddrArr=()
tcport=9300
function arraytostr(){
  local str
  local arr
  str+=[
  arr=($(echo "$@"))
  for((i=0;i<${#arr[*]};i++));
  do
    if [ $i -ne 0 ]
    then
       str+=,
    fi
    str+=${arr[i]}
    #echo ${str}
  done
  str+=]
  echo ${str}
  return $?
}

for((k=1;k<=3;k++));
do
   tcport=$((tcport+k))
   if [ $tcport -eq 9301 ]
   then  
       echo ${tcport} 
       MasterNameArr[$((k-1))]=\"master\"
       NodeAddrArr[$((k-1))]=\"master\" 
   else
       NodeAddrArr[$((k-1))]=\"node$((k-1))\"
   fi 
   echo ${NodeAddrArr[$((k-1))]}
   tcport=9300
done	
address=$(arraytostr ${NodeAddrArr[*]})
master=$(arraytostr ${MasterNameArr[*]})

if [ -f "docker-compose.yml" ];then
    rm -rf docker-compose.yml
fi
touch docker-compose.yml


echo 'version: "3"' >> docker-compose.yml
echo 'services:' >> docker-compose.yml

for((j=0;j<3;j++));
do
    title=node${j}
    inIp=9201
    outIp=9301
    inIp=$((inIp+j))
    outIp=$((outIp+j))
    nodename=node${j}
    ismaster=false 
    if [ -d "node${j}" ];then
       rm -rf node${j}
    fi    
    mkdir -p node${j}/conf	 
    if [ $j -eq 0 ]
    then
      nodename=master
      ismaster=true
    fi
    name=${nodename} is_master=${ismaster} inIp=${inIp} outIp=${outIp} address=${address} master=${master} envsubst < node.tmpl > node${j}/conf/es.yml
    title=${title} nodename=${nodename} inIp=${inIp} outIp=${outIp} envsubst < item.tmpl > temp.txt    
    value=$(<temp.txt)
    echo "$value" >> docker-compose.yml
    rm -rf temp.txt
done
echo 'networks:' >> docker-compose.yml
echo '  net-es:' >> docker-compose.yml
echo '    driver: bridge' >> docker-compose.yml
dos2unix docker-compose.yml
