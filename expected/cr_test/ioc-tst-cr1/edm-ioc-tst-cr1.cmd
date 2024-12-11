#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=IOC:TST:CR:01

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /reg/g/pcds/epics/ioc/common/cr_test/R1.0.0

#export TOP_SCREEN=crtScreens/crt.edl`
#edm -x -eolc	\
#	-m "IOC=IOC:TST:CR:01"	\
#	-m "P=TST:CR:01"	\
#	${TOP_SCREEN}  &
echo "No screens for the Generic StreamDevice yet."
