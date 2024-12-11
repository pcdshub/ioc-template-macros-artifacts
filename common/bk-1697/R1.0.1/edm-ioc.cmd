#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=$$IOC_PV

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd $$RELEASE

$$LOOP(DEVICE)
export TOP_SCREEN=screens/bk-1697.edl
edm -x -eolc	\
	-m "IOC=$$IOC_PV"	\
	-m "BASE=$$BASE"	\
	${TOP_SCREEN}  &
$$ENDLOOP(DEVICE)
