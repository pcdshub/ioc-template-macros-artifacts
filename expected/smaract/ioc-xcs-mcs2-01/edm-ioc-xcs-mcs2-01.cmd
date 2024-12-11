#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
        source /reg/g/pcds/pyps/config/common_dirs.sh
else
        source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=IOC:XCS:MCS2:01

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /reg/g/pcds/epics/ioc/common/smaract/R1.0.5

export TOP_SCREEN=`echo motorScreens/mcs2_tile17.edl`
edm -x -eolc    \
        -m "IOC=IOC:XCS:MCS2:01"       \
        -m "MOTOR=XCS:MCS2:01"   \
        ${TOP_SCREEN}  &