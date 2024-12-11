#! /bin/bash

# Setup the common directory env variables                                                                                                                                   
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh  ]; then
    source /reg/g/pcds/pyps/config/common_dirs.sh
else
    source /afs/slac/g/pcds/config/common_dirs.sh
fi

cd $$IOCTOP/raritanScreens
source $ENG_TOOLS_SCRIPTS/pcds_conda
$$LOOP(SNMP_DEVICE)
$$IF(IDX)$$ELSE(IDX)pydm --hide-nav-bar --hide-status-bar -m "base=$$BASE,num=`caget -tS $$BASE:MAX_SENSOR_NUM`" raritan.py &
$$ENDIF(IDX)
$$ENDLOOP(SNMP_DEVICE)
