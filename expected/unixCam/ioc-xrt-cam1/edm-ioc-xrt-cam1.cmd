#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh

SCREENS_TOP=${EPICS_SITE_TOP}-dev/screens/edm/${HUTCH}/current

#pushd ${SCREENS_TOP}
# Now launching edm from each IOCTOP release
# so each ioc can have it's own custom set of screens that matches which
# set of module depedencies that ioc was built with. 
pushd /reg/g/pcds/package/epics/3.14/ioc/common/unixCam/R3.6.7

# Setup ioc env variables
export IOC_PV=XRT:R05:IOC:41
export HUTCH=tst
export EVR_PV=NoEvr
export EVR_PV=XRT:R05:EVR:41

# Launch an edm viewer for each camera
export CAM=HXX:UM6:CVV:01
export TRIG_CH=0

edm -x -eolc	\
	-m "IOC=${IOC_PV}"		\
	-m "EVR=${EVR_PV}"		\
	-m "CAM=${CAM}"			\
	-m "CH=${TRIG_CH}"		\
	-m "P=${CAM},R=:"		\
	-m "DEV=${CAM}"			\
	-m "HUTCH=${HUTCH}"		\
	camScreens/liveImage.edl  &

