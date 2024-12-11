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

export IOC_PV=IOC:UED:VT50:01
export BASE=UED:VT50

pushd /reg/g/pcds/epics/ioc/common/PI_C663/R1.0.0/pi663Screens
edm -x -eolc	\
	-m "IOC=IOC:UED:VT50:01"		\
        -m "P=UED:VT50:"               \
        -m "TITLE=UED:VT50 C-663 Stepper Motor Controller" \
        -m "M1=UED:VT50:01" \
	motor.edl &
