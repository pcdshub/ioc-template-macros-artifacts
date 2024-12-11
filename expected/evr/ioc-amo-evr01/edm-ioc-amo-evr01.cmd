#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
elif [ -e /afs/slac/g/pcds/pyps/config/common_dirs.sh ]; then
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export EVR_PV=AMO:EVR:01
export IOC_PV=IOC:AMO:EVR01
export HUTCH=UNKNOWN

# Setup edm environment
if [ -f ${SETUP_SITE_TOP}/epicsenv-cur.sh ]; then
    source ${SETUP_SITE_TOP}/epicsenv-cur.sh
fi

pushd /reg/g/pcds/epics/ioc/common/evr/R1.3.0/screenLinks

# Launch edm
edm -x -eolc	\
	-m "IOC=${IOC_PV}"	\
	-m "EVR=${EVR_PV}"	\
	-m "HUTCH=${HUTCH}"	\
	event2Screens/evrSLAC.edl  &
