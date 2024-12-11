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

export TPR_PV=$$IF(TPR_PV,$$TPR_PV,$$NAME:NoTpr)
export TPE_PV=$$IF(TPE_PV)$$TPE_PV$$ELSE(TPE_PV)${TPR_PV}$$ENDIF(TPE_PV)
export TPR_TR=$$IF(TPR_TR,$$TPR_TR,0)
export TPR_CH=$$IF(TPR_CH,$$TPR_CH,${TPR_TR})
export TPR_SE=$$IF(TPR_SE,$$TPR_SE,${TPR_CH})

$$IF(EVR_PV)
export EVR_PV=$$EVR_PV
export EVR_TR=$$IF(EVR_TRIG,$$EVR_TRIG,0)
$$ELSE(EVR_PV)
export EVR_PV=$$NAME:NoEvr
export EVR_TR=0
$$ENDIF(EVR_PV)

$$IF(STAGE)
export EDM_TOP=qminiScreens/qminiStage.edl
$$ELSE(STAGE)
export EDM_TOP=qminiScreens/qmini.edl
$$ENDIF(STAGE)

export BASE_PV=$$NAME
export IOC_PV=$$IOCPVROOT

pushd $$IOCTOP/screenLinks
edm -x -eolc	\
	-m "BASE=${BASE_PV}"		\
$$IF(STAGE)
	-m "STAGE=$$STAGE"	\
$$ENDIF(STAGE)
	-m "IOC=${IOC_PV}"		\
	-m "TPR_PV=${TPR_PV}"	\
	-m "TPE_PV=${TPE_PV}"	\
	-m "TPR_TR=${TPR_TR}"	\
	-m "TPR_CH=${TPR_CH}"	\
	-m "TPR_SE=${TPR_SE}"	\
	-m "EVR_PV=${EVR_PV}"		\
	-m "EVR_TR=${EVR_TR}"		\
	${EDM_TOP} &

