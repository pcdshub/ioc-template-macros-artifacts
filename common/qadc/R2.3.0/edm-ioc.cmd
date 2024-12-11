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

export IOC_PV=$$IOC_PV
$$LOOP(QADC)
EDM_TOP=qadcTop.edl
export BASE=$$NAME
$$ENDLOOP(QADC)
$$LOOP(QADC134)
$$IF(LCLS2)
EDM_TOP=qadc134Top2.edl
$$ELSE(LCLS2)
EDM_TOP=qadc134Top1.edl
$$ENDIF(LCLS2)
export BASE=$$NAME
$$ENDLOOP(QADC134)

pushd $$IOCTOP/qadcScreens
edm -x -eolc	\
	-m "IOC=${IOC_PV}"		\
        -m "BASE=${BASE}"               \
	${EDM_TOP} >& /dev/null &
