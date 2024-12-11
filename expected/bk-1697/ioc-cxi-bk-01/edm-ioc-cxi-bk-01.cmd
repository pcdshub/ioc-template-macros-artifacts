#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=IOC:CXI:BKP:01

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /reg/g/pcds/epics/ioc/common/bk-1697/R1.0.1

export TOP_SCREEN=screens/bk-1697.edl
edm -x -eolc	\
	-m "IOC=IOC:CXI:BKP:01"	\
	-m "BASE=CXI:BKP:01"	\
	${TOP_SCREEN}  &