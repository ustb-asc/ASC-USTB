#!/bin/bash -e
n_cpu=4;

# copy from tinyroll's server
scp root@139.199.20.187:~/NAMD_Git-2017-11-14_Linux-x86_64-multicore.tar.gz .
tar xzf NAMD_Git-2017-11-14_Linux-x86_64-multicore.tar.gz

cd NAMD_Git-2017-11-14_Linux-x86_64-multicore

# --------------Run commends--------------------
# namd2 <configfile>
# namd2 +p<procs> <configfile>
# charmrun namd2 ++local +p<procs> <configfile>

./namd2 lib/replica/example/alanin_base.namd

# Longer test using four processes:
wget http://www.ks.uiuc.edu/Research/namd/utilities/apoa1.tar.gz
tar xzf apoa1.tar.gz
./charmrun +p4 ./namd2 apoa1/apoa1.namd
# 没有local这个选项
