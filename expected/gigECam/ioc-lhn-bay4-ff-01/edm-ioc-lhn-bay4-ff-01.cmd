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

export EVR_PV=EVR:LAS:LHN:04:FF
export TRIG_CH=7
export IOC_PV=IOC:LAS:LHN:BAY4:CAM:02
export CAM=LAS:LHN:BAY4:CAM:02
export HUTCH=lhn

export IF=ETH0

EDM_TOP=gigeScreens/gigeTop.edl
SCREENS_TOP=${EPICS_SITE_TOP}-dev/screens/edm/${HUTCH}/current

#pushd ${SCREENS_TOP}
# Now launching edm from new screenLinks directory under each IOCTOP release
# so each ioc can have it's own custom set of screens that matches which
# set of module depedencies that ioc was built with. 
pushd /reg/g/pcds/epics/ioc/common/gigECam/R5.0.3/screenLinks
edm -x -eolc	\
	-m "IOC=${IOC_PV}"		\
	-m "EVR=${EVR_PV}"		\
	-m "CH=${TRIG_CH}"		\
	-m "CAM=${CAM}"			\
	-m "P=${CAM},R=:"		\
	-m "EDM_TOP=${EDM_TOP}"	\
	-m "HUTCH=${HUTCH}"		\
	-m "IF=${IF}"			\
	${EDM_TOP} &

