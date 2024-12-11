#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh

pushd $$IOCTOP/screenLinks
edm -eolc -x -m "TPR_PV=$$TPR_PV,IOC=$$IOC_PV,DEVICE=$$TPR_PV,INST=0" tprTriggerScreens/tprFull.edl &

