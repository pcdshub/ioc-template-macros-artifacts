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

export EVR_PV=TMO:CAM:PEPPEX:01:NoEvr
export TRIG_CH=0
export IOC_PV=TMO:CAM:PEPPEX:IOC
export CAM=TMO:CAM:PEPPEX:01
export HUTCH=TMO

export IF=ENP1S0F0

export SYNCTS="/reg/g/pcds/epics/ioc/tmo/gigECam/R5.1.0/build/iocBoot/ioc-cam-peppex-01/syncts-ioc-cam-peppex-01.cmd"

EDM_TOP=gigeScreens/gigeTop.edl
SCREENS_TOP=${EPICS_SITE_TOP}-dev/screens/edm/${HUTCH}/current

#pushd ${SCREENS_TOP}
# Now launching edm from new screenLinks directory under each IOCTOP release
# so each ioc can have it's own custom set of screens that matches which
# set of module depedencies that ioc was built with. 
pushd /reg/g/pcds/epics/ioc/common/gigECam/R5.1.0/screenLinks
edm -x -eolc	\
	-m "IOC=${IOC_PV}"		\
	-m "EVR=${EVR_PV}"		\
	-m "CH=${TRIG_CH}"		\
	-m "CAM=${CAM}"			\
	-m "P=${CAM},R=:"		\
	-m "EDM_TOP=${EDM_TOP}"	\
	-m "HUTCH=${HUTCH}"		\
	-m "IF=${IF}"			\
	-m "SYNCTS=${SYNCTS}"	\
	${EDM_TOP} &

