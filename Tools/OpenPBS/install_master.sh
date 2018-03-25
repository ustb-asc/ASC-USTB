#!/bin/bash
service firewalld stop
yum install libxml2-devel openssl-devel gcc gcc-c++ boost-devel libtool-y
tar -zvxf torque-6.1.1.1.tar.gz
cd torque-6.1.1.1
./configure && make && make packages&& make install
cp contrib/init.d/{pbs_{server,sched,mom},trqauthd} /etc/init.d/
for i in pbs_server pbs_sched pbs_mom trqauthd; do chkconfig --add $i; chkconfig $ion; done
TORQUE=/usr/local/torque
echo "TORQUE=$TORQUE" >>/etc/profile
echo "export PATH=\$PATH:$TORQUE/bin:$TORQUE/sbin" >> /etc/profile
source /etc/profile
./torque.setuproot
for i in pbs_server pbs_sched pbs_mom trqauthd; do service $i start; done
echo "master" >> /var/spool/torque/server_priv/nodes
echo "slave" >> /var/spool/torque/server_priv/nodes
echo "$pbsserver master" >> /var/spool/torque/mom_priv/config
echo "$logevent 255" >> /var/spool/torque/mom_priv/config
ps -e | grep pbs
for i in pbs_server pbs_sched pbs_mom trqauthd; do service $i restart; done
qnodes
chkconfig pbs_server on
chkconfig pbs_sched on
chkconfig pbs_mom on
scp torque-package-{mom,clients}-linux-x86_64.sh slave:/root/
scp contrib/init.d/{pbs_mom,trqauthd} slave:/etc/init.d/
adduser devin