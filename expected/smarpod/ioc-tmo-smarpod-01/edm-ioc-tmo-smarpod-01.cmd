#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=IOC:TMO:SPD:01

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /reg/g/pcds/epics/ioc/common/SmarPod/R1.1.2/smarpodScreens

export TOP_SCREEN=smarpod.edl
edm -x -eolc	                \
	-m "IOC=IOC:TMO:SPD:01"	\
	-m "P=TMO:SPD:01"	        \
	-m "R=:"	        \
	${TOP_SCREEN}  &
