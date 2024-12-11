#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
        source /reg/g/pcds/pyps/config/common_dirs.sh
else
        source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=$$IOC_PV

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd $$RELEASE

export TOP_SCREEN=`echo agilent5322Screens/agilent5322.edl`
edm -x -eolc    \
	-m "DEV=$$DEVICE"      \
        ${TOP_SCREEN}  &
