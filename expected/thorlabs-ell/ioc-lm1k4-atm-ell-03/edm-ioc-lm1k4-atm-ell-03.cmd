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

export IOC_PV=IOC:LM1K4:ATM_DP1_TF1_SL1:ELL:0
pushd /reg/g/pcds/epics/ioc/common/thorlabs-ell/R0.0.7/ellScreens

export BASE=LM1K4:ATM_MP1:ELL:M1
edm -x -eolc	\
	-m "IOC=${IOC_PV}"  \
        -m "BASE=${BASE}"   \
	ellTop.edl &
export BASE=LM1K4:ATM_MP1:ELL:M3
edm -x -eolc	\
	-m "IOC=${IOC_PV}"  \
        -m "BASE=${BASE}"   \
	ellTop.edl &
export BASE=LM1K4:ATM_MP1:ELL:M2
edm -x -eolc	\
	-m "IOC=${IOC_PV}"  \
        -m "BASE=${BASE}"   \
	ellTop.edl &
