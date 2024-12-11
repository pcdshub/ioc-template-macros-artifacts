#! /bin/bash

# Setup the common directory env variables
if [ -e      /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source   /reg/g/pcds/pyps/config/common_dirs.sh
elif [ -e    /afs/slac/g/pcds/pyps/config/common_dirs.sh ]; then
	source   /afs/slac/g/pcds/pyps/config/common_dirs.sh
fi

# Setup edm environment
if [ -f    ${SETUP_SITE_TOP}/epicsenv-cur.sh ]; then
	source ${SETUP_SITE_TOP}/epicsenv-cur.sh
fi

export IOC_PV=IOC:LAS:PYR:0
pushd /reg/g/pcds/epics/ioc/common/pyreos/R1.0.0/pyreosScreens

export BASE=LAS:PYR
edm -x -eolc	\
	-m "IOC=${IOC_PV}"  \
        -m "BASE=${BASE}"   \
        -m "EVR=EVR:LAS:PYR:01" \
	-m "CH=6" \
	pyreosTop.edl &
