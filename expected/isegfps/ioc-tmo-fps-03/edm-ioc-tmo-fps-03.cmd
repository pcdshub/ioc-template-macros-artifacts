#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=IOC:TMO:FPS:03

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /reg/g/pcds/epics/ioc/common/isegFPS/R1.0.1

#export TOP_SCREEN=gsdScreens/gsd.edl`
#edm -x -eolc	\
#	-m "IOC=IOC:TMO:FPS:03"	\
#	-m "P=TMO:FPS:03"	\
#	${TOP_SCREEN}  &
echo "No screens for the Generic StreamDevice yet."
