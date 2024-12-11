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

export TPR_PV=CXI:LAS:SPL:SP2:NoTpr
export TPE_PV=${TPR_PV}
export TPR_TR=0
export TPR_CH=${TPR_TR}
export TPR_SE=${TPR_CH}

export EVR_PV=CXI:LAS:SPL:SP2:NoEvr
export EVR_TR=0

export EDM_TOP=qminiScreens/qmini.edl

export BASE_PV=CXI:LAS:SPL:SP2
export IOC_PV=IOC:CXI:LAS:SPL:SP2

pushd /reg/g/pcds/epics/ioc/common/qmini/R1.0.2/screenLinks
edm -x -eolc	\
	-m "BASE=${BASE_PV}"		\
	-m "IOC=${IOC_PV}"		\
	-m "TPR_PV=${TPR_PV}"	\
	-m "TPE_PV=${TPE_PV}"	\
	-m "TPR_TR=${TPR_TR}"	\
	-m "TPR_CH=${TPR_CH}"	\
	-m "TPR_SE=${TPR_SE}"	\
	-m "EVR_PV=${EVR_PV}"		\
	-m "EVR_TR=${EVR_TR}"		\
	${EDM_TOP} &

