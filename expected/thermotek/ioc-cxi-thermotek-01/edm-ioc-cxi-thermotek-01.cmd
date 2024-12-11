#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=IOC:CXI:TTK

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /reg/g/pcds/epics/ioc/common/thermotek/R1.0.6

export TOP_SCREEN=`echo thermotekScreens/thermotek.edl`
edm -x -eolc	\
	-m "IOC=IOC:CXI:TTK"	\
	-m "P=CXI:JF4M:TTK"	\
	${TOP_SCREEN}  &
