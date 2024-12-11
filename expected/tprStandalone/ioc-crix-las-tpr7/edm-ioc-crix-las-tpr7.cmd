#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh

pushd /reg/g/pcds/epics/ioc/common/tprStandalone/R1.2.0/screenLinks
edm -eolc -x -m "TPR_PV=CRIX:LAS:TPR:07,IOC=CRIX:IOC:LAS:TPR:07,DEVICE=CRIX:LAS:TPR:07,INST=0" tprTriggerScreens/tprFull.edl &

