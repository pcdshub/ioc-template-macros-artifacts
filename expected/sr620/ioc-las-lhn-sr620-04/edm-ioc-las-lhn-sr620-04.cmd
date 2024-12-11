#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
        source /reg/g/pcds/pyps/config/common_dirs.sh
else
        source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /cds/group/pcds/epics/ioc/common/sr620/R0.9.3

export TOP_SCREEN=`echo sr620Screens/sr620.edl`
edm -x -eolc    \
	-m "DEV=LAS:FS14:CNT:TI"      \
	-m "IOC=IOC:LAS:FS14:CNT:TI" \
        ${TOP_SCREEN}  &
