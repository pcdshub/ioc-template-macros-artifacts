#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export EVR_PV=$$EVR_PV
export IOC_PV=$$IOC_PV
export HUTCH=$$HUTCH

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd $EPICS_SITE_TOP-dev/screens/edm/${HUTCH}/current

# Launch edm
edm -x -eolc	\
	-m "IOC=${IOC_PV}"	\
	-m "EVR=${EVR_PV}"	\
	-m "HUTCH=${HUTCH}"	\
	event2Screens/evr$$EVR_TYPE.edl  &

