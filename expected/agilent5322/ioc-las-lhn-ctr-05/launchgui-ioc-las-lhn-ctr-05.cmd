#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
        source /reg/g/pcds/pyps/config/common_dirs.sh
else
        source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=LAS:LHN:IOC:CNT:05:FQ

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /cds/group/pcds/epics/ioc/common/agilent5322/R2.0.5

export TOP_SCREEN=`echo agilent5322Screens/agilent5322.edl`
edm -x -eolc    \
	-m "DEV=LAS:LHN:CNT:05:FQ"      \
        ${TOP_SCREEN}  &
