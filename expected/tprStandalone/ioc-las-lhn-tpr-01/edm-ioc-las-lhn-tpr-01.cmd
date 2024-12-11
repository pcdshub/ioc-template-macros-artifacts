#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh

pushd /cds/group/pcds/epics/ioc/common/tprStandalone/R1.2.0/screenLinks
edm -eolc -x -m "TPR_PV=LAS:LHN:TPR:01,IOC=LAS:IOC:LHN:TPR:01,DEVICE=LAS:LHN:TPR:01,INST=0" tprTriggerScreens/tprFull.edl &

