#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=RIX:MPOD:FIM:IOC:01
export HUTCH=rix

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /reg/g/pcds/epics/ioc/common/isegPower/R1.3.2

# Launch edm
edm -x -eolc	\
	-m "DEV=RIX:MPOD:FIM:01"	\
	-m "IOC=RIX:MPOD:FIM:IOC:01"	\
	-m "TITLE=ioc-rix-mpod-fim-01"	\
	-m "HUTCH=rix"	\
	-m "MOD0=MR3K2:FIM:SHV"	\
	-m "MOD1=MR4K2:FIM:SHV"	\
	isegPowerScreens/ioc-rix-mpod-fim-01.edl  &


