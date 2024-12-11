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

pushd $$IOCTOP/motorScreens
$$LOOP(MCS)
$$LOOP(COUNT)
edm -x -eolc	                        \
	-m "IOC=$$IOC_PV"	        \
	-m "MOTOR=$$BASE:m$$INDEX"	\
	emb-mcs-motor-small.edl &
$$ENDLOOP(COUNT)
$$ENDLOOP(MCS)

