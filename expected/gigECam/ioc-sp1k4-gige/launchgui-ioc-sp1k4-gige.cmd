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

export TPR_PV=TMO:CAM:TPR:02
export TPE_PV=SP1K4:PPM:CAM:TPE
export TPR_TR=00
export TPR_CH=${TPR_TR}
export TPR_SE=${TPR_CH}
export IOC_PV=SP1K4:PPM:CAM:IOC
export CAM=SP1K4:PPM:CAM
export HUTCH=TMO

export IF=ENP65S0F0

export SYNCTS="/reg/g/pcds/epics/ioc/tmo/gigECam/R5.1.0/build/iocBoot/ioc-sp1k4-gige/syncts-ioc-sp1k4-gige.cmd"

EDM_TOP=gigeScreens/gigeTprTop.edl
SCREENS_TOP=${EPICS_SITE_TOP}-dev/screens/edm/${HUTCH}/current

#pushd ${SCREENS_TOP}
# Now launching edm from new screenLinks directory under each IOCTOP release
# so each ioc can have it's own custom set of screens that matches which
# set of module depedencies that ioc was built with. 
pushd /reg/g/pcds/epics/ioc/common/gigECam/R5.1.0/screenLinks
edm -x -eolc	\
	-m "IOC=${IOC_PV}"		\
	-m "TPR=${TPR_PV}"		\
	-m "TPR_PV=${TPR_PV}"	\
	-m "TPE_PV=${TPE_PV}"	\
	-m "TPR_TR=${TPR_TR}"	\
	-m "TPR_CH=${TPR_CH}"	\
	-m "TPR_SE=${TPR_SE}"	\
	-m "CAM=${CAM}"			\
	-m "P=${CAM},R=:"		\
	-m "EDM_TOP=${EDM_TOP}"	\
	-m "HUTCH=${HUTCH}"		\
	-m "IF=${IF}"			\
	-m "SYNCTS=${SYNCTS}"	\
	${EDM_TOP} &

