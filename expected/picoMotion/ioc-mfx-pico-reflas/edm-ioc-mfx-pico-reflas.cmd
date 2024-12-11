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

EDM_TOP=motor8x.edl
export IOC_PV=IOC:MFX:REF:PIC
export BASE=MFX:REF:PIC

pushd /reg/g/pcds/epics/ioc/common/picoMotion/R4.0.1/picoScreens
edm -x -eolc	\
	-m "IOC=${IOC_PV}"		\
        -m "P=${BASE}:"               \
        -m "TITLE=MFX:REF:PIC 8742 Picomotor Controller" \
        -m "M1=01" \
        -m "M2=LEFT" \
        -m "M3=03" \
        -m "M4=04" \
        -m "M5=05" \
        -m "M6=06" \
        -m "M7=RIGHT" \
        -m "M8=08" \
	${EDM_TOP} &
