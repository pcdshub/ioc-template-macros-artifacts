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

EDM_TOP=motor1x.edl
export IOC_PV=IOC:CXI:USR:PIC
export BASE=CXI:USR:PIC

pushd /reg/g/pcds/epics/ioc/common/picoMotion/R4.0.2/picoScreens
edm -x -eolc	\
	-m "IOC=${IOC_PV}"		\
        -m "P=${BASE}:"               \
        -m "TITLE=CXI:USR:PIC 8742 Picomotor Controller" \
        -m "M1=01" \
	${EDM_TOP} &
