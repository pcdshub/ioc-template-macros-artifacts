#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh

$$IF(SCREENS_TOP)
SCREENS_TOP=$$SCREENS_TOP
$$ELSE(SCREENS_TOP)
SCREENS_TOP=${EPICS_SITE_TOP}-dev/screens/edm/${HUTCH}/current
$$ENDIF(SCREENS_TOP)

#pushd ${SCREENS_TOP}
# Now launching edm from each IOCTOP release
# so each ioc can have it's own custom set of screens that matches which
# set of module depedencies that ioc was built with. 
pushd $$IOCTOP

# Setup ioc env variables
export IOC_PV=$$IOC_PV
export HUTCH=$$IF(HUTCH,$$HUTCH,tst)
export EVR_PV=NoEvr
$$LOOP(EVR)
export EVR_PV=$$NAME
$$ENDLOOP(EVR)

# Launch an edm viewer for each camera
$$LOOP(CAMERA)
export CAM=$$NAME
export TRIG_CH=$$TRIG

edm -x -eolc	\
	-m "IOC=${IOC_PV}"		\
	-m "EVR=${EVR_PV}"		\
	-m "CAM=${CAM}"			\
	-m "CH=${TRIG_CH}"		\
	-m "P=${CAM},R=:"		\
	-m "DEV=${CAM}"			\
	-m "HUTCH=${HUTCH}"		\
	camScreens/liveImage.edl  &

$$ENDLOOP(CAMERA)
