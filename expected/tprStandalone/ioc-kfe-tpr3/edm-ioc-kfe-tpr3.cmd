#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh

pushd /reg/g/pcds/epics/ioc/common/tprStandalone/R1.1.6/screenLinks
edm -eolc -x -m "TPR_PV=KFE:CAM:TPR:03,IOC=KFE:IOC:CAM:TPR:03,DEVICE=KFE:CAM:TPR:03,INST=0" tprTriggerScreens/tprFull.edl &

