#!/bin/sh
x86_64_arch='unknown'
if [[ `uname -r` == *el5* ]]; then
  x86_64_arch='x86_64-linux'
elif [[ `uname -r` == *el6* ]]; then
  x86_64_arch='x86_64-rhel6'
  BUILD32=false
elif [[ `uname -r` == *el7* ]]; then
  x86_64_arch='x86_64-rhel7'
  BUILD32=false
fi
/cds/group/pcds/package/external/hsd/v4.1.0/bin/${x86_64_arch}-opt/hsd_init -d /dev/datadev_0 -1 -A
