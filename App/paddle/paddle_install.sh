
#------------------Source Install-----------------------

# dependencies install
sudo yum -y update
sudo yum install -y epel-release
sudo yum install -y make cmake3 python-devel python-pip gcc-gfortran swig git
sudo yum install -y zlib-devel gcc-g++ golang
sudo yum install -y openssl-devel

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
                            protobuf

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

#
# sudo apt-get update
# sudo apt-get install -y git curl gcc g++ gfortran make build-essential automake cmake
# sudo apt-get install -y python python-pip python-numpy libpython-dev bison
# sudo apt-get install -y golang-go swig
# sudo apt-get install -y libboost-dev
# sudo pip install protobuf sphinx

mkdir build && cd build

# paddle install
# you can add build option here, such as:
cmake .. -DCMAKE_INSTALL_PREFIX=<path to install>
# please use sudo make install, if you want to install PaddlePaddle into the system
make -j `nproc` && make install
# set PaddlePaddle installation path in ~/.bashrc
export PATH=<path to install>/bin:$PATH
# install PaddlePaddle Python modules.
sudo pip install <path to install>/opt/paddle/share/wheels/*.whl


#--------------------deb Install---------------------------
sudo apt-get install gdebi
gdebi paddle-*-cpu.deb
