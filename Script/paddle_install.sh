#!/bin/sh
sudo apt-get install -y cmake \
                        swig \
                        golang-go \
                        libboost-dev
sudo pip install --upgrade pip
sudo pip install numpy

mkdir build && cd build
cmake -DWITH_GPU=OFF -DWITH_TESTING=OFF -DWITH_AVX=OFF ..


# docker pull docker.paddlepaddle.org/paddle:0.10.0rc3-noavx



#---------------------切换GCC版本------------------------
sudo apt-get install gcc-4.8 gcc-4.8-multilib   g++-4.8 g++-4.8-multilib

# gcc-4.8-plugin-dev gcc-4.8-source
#---------------update-alternatives版本管理方法----------
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 40
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 50
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 50
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 40

#--------------------列出选项---------------------
sudo update-alternatives --config g++
sudo update-alternatives --config gcc

#--------------------删除选项---------------------
sudo update-alternatives --remove gcc /usr/bin/gcc-4.8
sudo update-alternatives --remove gcc /usr/bin/g++-4.8
