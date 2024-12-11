#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=TMO:MPOD:FIM:IOC:01
export HUTCH=tmo

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /cds/group/pcds/epics/ioc/common/isegPower/R1.3.2

# Launch edm
edm -x -eolc	\
	-m "DEV=TMO:MPOD:FIM:01"	\
	-m "IOC=TMO:MPOD:FIM:IOC:01"	\
	-m "TITLE=ioc-tmo-mpod-fim-01"	\
	-m "HUTCH=tmo"	\
	-m "MOD0=MR2K4:FIM:SHV"	\
	-m "MOD1=MR3K4:FIM:SHV"	\
	isegPowerScreens/ioc-tmo-mpod-fim-01.edl  &


