#!/bin/bash
#install jdk
cd /usr/local/bin
mkdir java
cd java
echo "download jdk---->"
sleep 3
wget https://repo.huaweicloud.com/java/jdk/8u202-b08/jdk-8u202-linux-x64.tar.gz
echo "extract jdk--->"
sleep 3
tar -xvzf jdk-8u202-linux-x64.tar.gz
echo "remove jdk package---->"
sleep 3
rm  -rf jdk-8u202-linux-x64.tar.gz
echo "setting jdk environment---->"
sleep 3
echo  'export JAVA_HOME=/usr/local/bin/java/jdk1.8.0_202' >> /etc/profile
echo  'export JRE_HOME=${JAVA_HOME}/jre' >> /etc/profile
echo  'export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib' >> /etc/profile
echo  'export PATH=$PATH:${JAVA_HOME}/bin'  >> /etc/profile
source /etc/profile
echo "jdk installed---->"
#install tomcat
echo "download tomcat---->"
cd /usr/local/bin
sleep 3
wget https://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-9/v9.0.36/bin/apache-tomcat-9.0.36.tar.gz
echo "extract tomcat---->"
sleep 3
tar -xvzf apache-tomcat-9.0.36.tar.gz
echo "remove tomcat package---->"
sleep 3
rm -rf apache-tomcat-9.0.36.tar.gz
mv apache-tomcat-9.0.36 tomcat
echo "tomcat installed"
sleep 3
echo 'please use <source /etc/profile> command to make java work'


echo "start to install mysql"
sleep 3
sudo apt-get install mysql-server -y
sudo apt install mysql-client -y
sudo apt install libmysqlclient-dev -y
echo "enable mysql start while system boot"
sleep 3
systemctl enable mysql
echo "start server mysql"
sleep 3
systemctl start mysql
echo -e -n '\033[1;32m setting mysql root passwd\033[0m'
sleep 3
read mysql_passwd
mysql -u root -e "update mysql.user  set authentication_string=password('${mysql_passwd}') where user='root';flush privileges;"
echo "enable remote login in"
sleep 3
sed -i '43c #bind-address= 127.0.0.1' /etc/mysql/mysql.conf.d/mysqld.cnf 
systemctl restart mysql