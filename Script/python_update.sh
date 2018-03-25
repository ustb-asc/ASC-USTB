#!/bin/bash

#------------------ 更换阿里云yum源---------------
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo
yum makecahe


#------------------ 安装python2.7 -----------------
wget https://www.python.org/ftp/python/2.7.14/Python-2.7.14.tgz
tar xzvf Python-2.7.14.tgz
cd Python-2.7.14.tgz

#-------------改zlib\openssl-------------
yum install openssl -y
yum install zlib zlib-devel -y
yum install openssl-devel -y
vim Module/Setup
# 214,219,220,221,467 去掉注释

./configure  --prefix=/usr/local/python/python2.7
make install

# -----------------备份------------
mv /usr/bin/python /usr/bin/python.old
sudo ln -s -f  python_old python2.6
vim /usr/bin/yum
# 其中第一行python->python2.6

ln -s /usr/local/python/python2.7/bin/python2.7 /usr/bin/python

#-----------------安装pip-------------

python get-pip.py
#----------------备份------------
cd /usr/bin
mv pip2 pip_old
mv pip2 pip2_old
mv pip2.6 pip2.6_old

ln -s /usr/local/python/python2.7/bin/pip /usr/bin/pip
ln -s /usr/local/python/python2.7/bin/pip2 /usr/bin/pip2
ln -s /usr/local/python/python2.7/bin/pip2.7 /usr/bin/pip2.7
