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

export IOC_PV=IOC:LM1K4:COM:ELL:2
pushd /reg/g/pcds/epics/ioc/common/thorlabs-ell/R0.0.7/ellScreens

export BASE=LM1K4:COM:ELL:2:M2
edm -x -eolc	\
	-m "IOC=${IOC_PV}"  \
        -m "BASE=${BASE}"   \
	ellTop.edl &