#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
elif [ -e /afs/slac/g/pcds/pyps/config/common_dirs.sh ]; then
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export EVR_PV=$$EVR_PV
export IOC_PV=$$IOC_PV
export HUTCH=$$IF(HUTCH,$$HUTCH,UNKNOWN)

# Setup edm environment
if [ -f ${SETUP_SITE_TOP}/epicsenv-cur.sh ]; then
    source ${SETUP_SITE_TOP}/epicsenv-cur.sh
fi

pushd $$IOCTOP/screenLinks

# Launch edm
edm -x -eolc	\
	-m "IOC=${IOC_PV}"	\
	-m "EVR=${EVR_PV}"	\
	-m "HUTCH=${HUTCH}"	\
$$IF(EVR_TYPE,CPCI)
    event2Screens/evrPMC.edl  &
$$ELSE(EVR_TYPE)
	event2Screens/evr$$EVR_TYPE.edl  &
$$ENDIF(EVR_TYPE)
