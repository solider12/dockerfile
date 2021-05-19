#!/bin/bash
sudo tar -zxf jdk-8u202-linux-x64.tar.gz
mv jdk1.8.0_202 /usr/local/java8
rm -rf jdk-8u202-linux-x64.tar.gz
echo 'export JAVA_HOME=/usr/local/java8' >> ~/.bashrc
echo 'export JRE_HOME=${JAVA_HOME}/jre' >> ~/.bashrc
echo 'export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib' >> ~/.bashrc
echo 'export PATH=${JAVA_HOME}/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
chmod -R 777 /usr/local/java8/bin
chmod -R 777 /usr/local/java8/jre


