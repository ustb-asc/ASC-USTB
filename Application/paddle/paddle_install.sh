
#------------------Source Install-----------------------
# git
git clone https://github.com/PaddlePaddle/Paddle paddle
cd paddle

# dependencies install
sudo apt-get update
sudo apt-get install -y git curl gcc g++ gfortran make build-essential automake cmake
sudo apt-get install -y python python-pip python-numpy libpython-dev bison
sudo apt-get install -y golang-go swig
sudo apt-get install -y libboost-dev
sudo pip install protobuf sphinx

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
