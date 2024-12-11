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

$$IF(APP,gigeTpr)
export TPR_PV=$$IF(TPR_PV,$$TPR_PV,$$CAM_PV:NoTpr)
$$IF(TPR_PV)
export TPE_PV=$$IF(TPE_PV,$$TPE_PV,$$TPR_PV)
$$ELSE(TPR_PV)
export TPE_PV=$$IF(TPE_PV,$$TPE_PV,$$CAM_PV:NoTpr)
$$ENDIF(TPR_PV)
export TPR_TR=$$IF(TPR_TR,$$TPR_TR,0)
export TPR_CH=$$IF(TPR_CH,$$TPR_CH,${TPR_TR})
export TPR_SE=$$IF(TPR_SE,$$TPR_SE,${TPR_CH})
$$ELSE(APP)
export EVR_PV=$$IF(EVR_PV,$$EVR_PV,$$CAM_PV:NoEvr)
export TRIG_CH=$$IF(EVR_TRIG,$$EVR_TRIG,0)
$$ENDIF(APP)
export IOC_PV=$$IOC_PV
export CAM=$$CAM_PV
export HUTCH=$$IF(HUTCH,$$HUTCH,tst)

export IF=$$IF(NET_IF,$$NET_IF,ETH)

EDM_TOP=gigeScreens/$$IF(APP,$$APP,gige)Top.edl
$$IF(SCREENS_TOP)
SCREENS_TOP=$$SCREENS_TOP
$$ELSE(SCREENS_TOP)
SCREENS_TOP=${EPICS_SITE_TOP}-dev/screens/edm/${HUTCH}/current
$$ENDIF(SCREENS_TOP)

#pushd ${SCREENS_TOP}
# Now launching edm from new screenLinks directory under each IOCTOP release
# so each ioc can have it's own custom set of screens that matches which
# set of module depedencies that ioc was built with. 
pushd $$IOCTOP/screenLinks
edm -x -eolc	\
	-m "IOC=${IOC_PV}"		\
$$IF(APP,gigeTpr)
	-m "TPR=${TPR_PV}"		\
	-m "TPR_PV=${TPR_PV}"	\
	-m "TPE_PV=${TPE_PV}"	\
	-m "TPR_TR=${TPR_TR}"	\
	-m "TPR_CH=${TPR_CH}"	\
	-m "TPR_SE=${TPR_SE}"	\
$$ELSE(APP)
	-m "EVR=${EVR_PV}"		\
	-m "CH=${TRIG_CH}"		\
$$ENDIF(APP)
	-m "CAM=${CAM}"			\
	-m "P=${CAM},R=:"		\
	-m "EDM_TOP=${EDM_TOP}"	\
	-m "HUTCH=${HUTCH}"		\
	-m "IF=${IF}"			\
	${EDM_TOP} &

