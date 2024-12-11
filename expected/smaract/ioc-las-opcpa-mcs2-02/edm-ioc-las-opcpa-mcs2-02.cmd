#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
        source /reg/g/pcds/pyps/config/common_dirs.sh
else
        source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=IOC:LAS:OPCPA:MCS2:02

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /cds/group/pcds/epics/ioc/common/smaract/R1.0.23

export TOP_SCREEN=`echo motorScreens/mcs2_tile3.edl`
edm -x -eolc    \
        -m "IOC=IOC:LAS:OPCPA:MCS2:02"       \
        -m "MOTOR=LAS:OPCPA:MCS2:02"   \
        ${TOP_SCREEN}  &
