#!/bin/bash -e
# ------parament define------------------
target=$1;
server_ip="192.168.1.1";




# complie env install
yum install -y mpich \
                gfortran \
                gcc-c++ \
                python \
                python-pip \
                graphviz \
                nfs-utils \
                rpcbind \
                tmux \
                git

pip install gprof2dot # gprof2dot change gmon.out to png


# -----------------start service----------------
service rpcbind start
service nfs start
chkconfig rpcbind on
chkconfig nfs on

if [[ $target == "Master" ]]
then
  mkdir /nfs
  echo "/nfs ${server_ip}(rw,no_root_squash,no_subtree_check)" > /etc/exports
  exportfs -a
fi


if [[ $target == "Slave" ]]
then
  mkdir -p /nfs
  mount -t nfs ${server_ip}:/nfs /nfs
  echo "${server_ip}:/nfs /nfs nfs rw,tcp,intr 0 1" >> /etc/fstab
fi

# Inter VTune install process
# -----------------------------Need download
if [[ $target == "VTune" ]]
then
  cd ~
  tar -zxvf vtune_amplifier_2018.tar.gz
  cd vtune_amplifier_2018
  sh install.sh
  # Install Processing: Accept + Free
  source /opt/intel/vtune_amplifier_2018.0.2.525261/amplxe-vars.sh
  # Run command: amplxe-cl && amplxe-gui
  echo  "kernel/yama/ptrace_scope = 1" >> /etc/sysctl.conf
  sudo sysctl -p
fi



# atalas install (Stable 3.10.3)
if [[ $target == "atalas" ]] || [[ -z "$target" ]]
then
    cd ~
    wget -v https://jaist.dl.sourceforge.net/project/math-atlas/Stable/3.10.3/atlas3.10.3.tar.bz2
    tar -jxvf atlas3.10.3.tar.bz2
    cd ATLAS
    mkdir build
    cd build
    ../configure
    make
fi


# hpl install (Lastest 2.2)
if [[ $target == "hpl" ]] || [[ -z "$target" ]]
then
  cd ~
  wget -v http://www.netlib.org/benchmark/hpl/hpl-2.2.tar.gz
  tar -zxvf hpl-2.2.tar.gz
  cd hpl-2.2/setup
  sh make_generic
  cd ../
  cp setup/Make.Linux_PII_CBLAS_gm  Make.test
fi


# --------------------------make set----------------------------
sed -i -n '64s/^.*$/ARCH         = test／' Make.test
sed -i -n '70s/^.*$/TOPdir       = $(HOME)/hpl-2.2／' Make.test
sed -i -n '84s/^.*$/MPdir        = /usr/local/mpich／' Make.test
sed -i -n '85s/^.*$/MPinc        = -I$(MPdir)/include／' Make.test
sed -i -n '86s/^.*$/MPlib        = $(MPdir)/lib/libmpi.so／' Make.test
sed -i -n '95s/^.*$/LAdir        = $(HOME)/ATLAS/build/lib／' Make.test

# ------set temple-------
# ARCH         = test
# TOPdir       = $(HOME)/hpl-2.2
# MPdir        = /usr/local/mpich
# MPinc        = -I $(MPdir)/include
# MPlib        = $(MPdir)/lib/libmpich.a
# LAdir        = $(HOME)/ATLAS/build/lib
# LAlib        = $(LAdir)/libf77blas.a $(LAdir)/libatlas.a

make arch=test
cd bin/test

# ------single node-------
./xhpl
# ------Analyces----------
#amplxe-cl -collect hotspots -r xhpl_hot ./xhpl


# ------muti node---------
# machinefile include every node
if [[ $target == 'mult']]
then
    mpiexec -f ~/mpi_testing/machinefile -n 32 ./xhpl
if



# --------------------------test examples-----------------------
# HPLinpack benchmark input file
# Innovative Computing Laboratory, University of Tennessee
# HPL.out      output file name (if any)
# 6            device out (6=stdout,7=stderr,file)
# 1            # of problems sizes (N)
# 5040         Ns
# 1            # of NBs
# 128          NBs
# 0            PMAP process mapping (0=Row-,1=Column-major)
# 1            # of process grids (P x Q)
# 1            Ps
# 1            Qs
# 16.0         threshold
# 1            # of panel fact
# 2            PFACTs (0=left, 1=Crout, 2=Right)
# 1            # of recursive stopping criterium
# 4            NBMINs (>= 1)
# 1            # of panels in recursion
# 2            NDIVs
# 1            # of recursive panel fact.
# 1            RFACTs (0=left, 1=Crout, 2=Right)
# 1            # of broadcast
# 1            BCASTs (0=1rg,1=1rM,2=2rg,3=2rM,4=Lng,5=LnM)
# 1            # of lookahead depth
# 1            DEPTHs (>=0)
# 2            SWAP (0=bin-exch,1=long,2=mix)
# 64           swapping threshold
# 0            L1 in (0=transposed,1=no-transposed) form
# 0            U  in (0=transposed,1=no-transposed) form
# 1            Equilibration (0=no,1=yes)
# 8            memory alignment in double (> 0)
