#!/bin/bash -e
n_cpu=4;
#------------------Source Install-----------------------
# dependencies install
sudo yum -y update
sudo yum install -y epel-release
sudo yum install -y make cmake3 python-devel python-pip gcc-gfortran swig git
sudo yum install -y zlib-devel gcc-g++ golang
sudo yum install -y openssl-devel
sudo yum install -y boost boost-devel  boost-doc

# install python-2.7.13
wget http://mirrors.sohu.com/python/2.7.13/Python-2.7.13.tar.xz
tar xf Python-2.7.13.tar.xz
cd Python-2.7.13
./configure  --with-zlib
sed -i '218s/#//' Modules/Setup.dist
sed -i '219s/#//' Modules/Setup.dist
sed -i '220s/#//' Modules/Setup.dist
sed -i '221s/#//' Modules/Setup.dist
sed -i '467s/#//' Modules/Setup.dist

make && make install
make clean && make distclean
mv /usr/bin/python /usr/bin/python2.6
ln -s /usr/local/bin/python2.7 /usr/bin/python
sed -i '1s/python/python2.6/' /usr/bin/yum

# install pip
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
ln -s -f  /usr/local/bin/pip2.7 /usr/bin/pip

pip install -U pip
sudo pip install -i https://pypi.tuna.tsinghua.edu.cn/simple \
                            wheel numpy \
                            protobuf \
                            sphinx

# GCC update
wget http://ftp.gnu.org/gnu/gcc/gcc-6.1.0/gcc-6.1.0.tar.bz2
tar -jxvf gcc-6.1.0.tar.bz2
cd gcc-6.1.0
./contrib/download_prerequisites
mkdir gcc-build-6.1.0
cd gcc-build-6.1.0
../configure -enable-checking=release -enable-languages=c,c++ -disable-multilib
make && make install



# git clone
git clone https://github.com/PaddlePaddle/Paddle paddle
cd paddle
export CMAKE_CXX_COMPILER=/usr/local/bin/g++
export CMAKE_C_COMPILER=/usr/local/bin/gcc
mkdir build && cd build

# paddle install
# you can add build option here, such as:
cmake3 ..  #-DCMAKE_INSTALL_PREFIX=<path to install>
# please use sudo make install, if you want to install PaddlePaddle into the system
make -j ${n_cpu} && make install

# ----------------------Need to down mklml over Wall----------------
# cd build/third_party/mklml/src/extern_mklml
# # du -sh mklml_lnx_2018.0.1.20171007.tgz  # should 75M, else failed
# wget --no-check-certificate https://github.com/01org/mkl-dnn/releases/download/v0.11/mklml_lnx_2018.0.1.20171007.tgz -c -O mklml_lnx_2018.0.1.20171007.tgz
# tar zxf mklml_lnx_2018.0.1.20171007.tgz
# touch ../extern_mklml-stamp/extern_mklml-download
# rm -rf build/third_party/mkldnn
# rm -rf build/third_party/install/mkldnn



# set PaddlePaddle installation path in ~/.bashrc
export PATH=<path to install>/bin:$PATH
# install PaddlePaddle Python modules.
sudo pip install <path to install>/opt/paddle/share/wheels/*.whl
