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
$$LOOP(QADC)
/cds/group/pcds/package/external/hsd/v2.0.1/bin/${x86_64_arch}-opt/hsd_init -d $$DEVICE -C -X -R -T 0
$$ENDLOOP(QADC)
$$LOOP(QADC134)
/cds/group/pcds/package/external/hsd/v4.1.0/bin/${x86_64_arch}-opt/hsd_init -d $$DEVICE -1 -A
$$ENDLOOP(QADC134)
