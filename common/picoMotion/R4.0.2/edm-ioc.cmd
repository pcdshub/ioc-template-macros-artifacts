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

EDM_TOP=motor$$COUNT(MOTOR)x.edl
export IOC_PV=$$IOC_PREFIX
export BASE=$$PREFIX

pushd $$IOCTOP/picoScreens
edm -x -eolc	\
	-m "IOC=${IOC_PV}"		\
        -m "P=${BASE}:"               \
        -m "TITLE=$$IF(TITLE,$$TITLE,$$PREFIX 8742 Picomotor Controller)" \
$$LOOP(MOTOR)
        -m "M$$CALC{INDEX+1}=$$NAME" \
$$ENDLOOP(MOTOR)
	${EDM_TOP} &
