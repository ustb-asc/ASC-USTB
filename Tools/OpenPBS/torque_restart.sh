#!/bin/bash
for i in pbs_server pbs_sched pbs_mom trqauthd;
  do service $i restart; 
done
