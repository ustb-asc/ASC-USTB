#!/bin/bash
# use bash to login
# StuNo. & Password
username=''
password=''
curl --retry 3 --data  "DDDDD=${username}&upass=${password}&0MKKey=123456789" http://202.204.48.66 --silent -o LOGIN_STATUS.out
echo "Login Success!!"
