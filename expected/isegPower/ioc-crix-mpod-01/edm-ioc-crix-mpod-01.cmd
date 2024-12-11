#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=CRIX:MPOD:01:IOC
export HUTCH=rix

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /reg/g/pcds/epics/ioc/common/isegPower/R1.3.2

# Launch edm
edm -x -eolc	\
	-m "DEV=CRIX:MPOD:01"	\
	-m "IOC=CRIX:MPOD:01:IOC"	\
	-m "TITLE=ioc-crix-mpod-01"	\
	-m "HUTCH=rix"	\
	-m "MOD0=CRIX:MPOD:01"	\
	-m "MOD1=CRIX:MPOD:01"	\
	-m "MOD2=CRIX:MPOD:01"	\
	-m "MOD3=CRIX:MPOD:01"	\
	-m "MOD4=CRIX:MPOD:01"	\
	-m "MOD5=CRIX:MPOD:01"	\
	isegPowerScreens/ioc-crix-mpod-01.edl  &


