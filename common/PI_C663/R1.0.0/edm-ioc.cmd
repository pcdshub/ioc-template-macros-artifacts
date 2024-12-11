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

export IOC_PV=$$IOC_PREFIX
export BASE=$$PREFIX

pushd $$IOCTOP/pi663Screens
$$LOOP(MOTOR)
edm -x -eolc	\
	-m "IOC=$$IOC_PREFIX"		\
        -m "P=$$PREFIX:"               \
        -m "TITLE=$$IF(TITLE,$$TITLE,$$PREFIX C-663 Stepper Motor Controller)" \
        -m "M1=$$PREFIX:$$NAME" \
	motor.edl &
$$ENDLOOP(MOTOR)
