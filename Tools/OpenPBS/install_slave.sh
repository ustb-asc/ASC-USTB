#!/bin/bash
service firewalld stop
./torque-package-clients-linux-x86_64.sh --install
./torque-package-mom-linux-x86_64.sh --install
echo "$pbsserver master" >> /var/spool/torque/mom_priv/config
echo "$logevent 225" >> /var/spool/torque/mom_priv/config
echo "slave" >> /var/spool/torque/server_priv/nodes
for i in pbs_mom trqauthd; do service $i start; done
chkconfig pbs_mom on