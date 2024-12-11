#! /bin/bash

# Setup the common directory env variables                                                                                                                                   
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh  ]; then
    source /reg/g/pcds/pyps/config/common_dirs.sh
else
    source /afs/slac/g/pcds/config/common_dirs.sh
fi

cd /cds/group/pcds/epics/ioc/common/raritan/R1.0.1/raritanScreens
source $ENG_TOOLS_SCRIPTS/pcds_conda
pydm --hide-nav-bar --hide-status-bar -m "base=LAS:SRC800:01,num=`caget -tS LAS:SRC800:01:MAX_SENSOR_NUM`" raritan.py &
