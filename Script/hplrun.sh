#!/bin/bash -e
# Usage: ./hplrun.sh DATA_DIR
#        Use screen to run process if you may detach from ssh.
# ------parameter define------
if [ $# != 1 ]; then
    echo "Wrong Parameters"
    EXIT 1
fi
# LINKPACK配置文件所在目录
DATA_DIR=$1
DATA_FILES=`ls $DATA_DIR/*.dat | awk -F '/' '{print $NF}'`

# ------parameter define------
MACHINE_FILE="/home/mpi_config_file"
TOTAL_PROCS="8"
LINKPACK="/home/asc/hpl/bin/Linux_xeon/xhpl"
LINKPACK_DATA="/home/asc/hpl/bin/Linux_xeon/HPL.dat"
LINKPACK_BAK="/home/asc/hpl/bin/Linux_xeon/HPL.bak"
OUTDIR="$DATA_DIR/OUT"
if [ ! -d $OUTDIR ]; then
  mkdir $OUTDIR
fi
MPI="mpirun"
MPIFLAGS="-f $MACHINE_FILE -n $TOTAL_PROCS $LINKPACK"

# 输出配置信息
clear
echo "################## GLOBAL CONFIG ##################"
echo "----------------------- MPI -----------------------"
echo "MPIRUN:           $MPI"
echo "-------------------- LINKPACK ---------------------"
echo "HPL:              $LINKPACK"
echo ""
echo ""
echo "################# RUNNING CONFIG ##################"
echo "MACHINE FILE:     $MACHINE_FILE"
echo "TOTAL PROCESSES:  $TOTAL_PROCS"
echo "SRC DATA DIR:     $DATA_DIR"
echo "DATA FILE:"
for TEMP_FILE in ${DATA_FILES[@]}; do
    echo "                  $TEMP_FILE"
done
echo "OUT DIR:          $OUTDIR"
echo "---------------------------------------------------"
echo ""

# 备份原来的CONFIG
cp -f $LINKPACK_DATA $LINKPACK_BAK

# LINKPACK测试
for TEMP_FILE in ${DATA_FILES[@]}; do
    echo ""
    echo ""
    echo ""
    echo "CONFIG DATA: $TEMP_FILE"
    IN_FILE="$DATA_DIR/$TEMP_FILE"
    OUT_FILE="$OUTDIR/$TEMP_FILE.out"
    # 替换配置文件
    cp -f $IN_FILE $LINKPACK_DATA
    # 执行 输出至$OUTDIR
    $MPI $MPIFLAGS | tee $OUT_FILE
done

# 恢复原来的CONFIG
cp -f $LINKPACK_BAK $LINKPACK_DATA