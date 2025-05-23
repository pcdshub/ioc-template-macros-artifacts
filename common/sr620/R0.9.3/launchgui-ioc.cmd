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

echo "Launching EDM screen because there is no PyDM screen yet!"
export TOP_SCREEN=`echo sr620Screens/sr620.edl`
edm -x -eolc    \
	-m "DEV=$$DEVICE"      \
	-m "IOC=IOC:$$DEVICE" \
        ${TOP_SCREEN}  &
