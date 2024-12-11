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
edm -eolc -x -m "TPR_PV=DET:ASC:TPR:01,IOC=DET:IOC:ASC:TPR:01,DEVICE=DET:ASC:TPR:01,INST=0" tprTriggerScreens/tprFull.edl &

