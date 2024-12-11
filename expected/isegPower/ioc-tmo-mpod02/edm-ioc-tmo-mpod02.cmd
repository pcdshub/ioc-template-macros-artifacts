#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=TMO:MPOD:02:IOC
export HUTCH=tmo

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /cds/group/pcds/epics/ioc/common/isegPower/R1.3.2

# Launch edm
edm -x -eolc	\
	-m "DEV=TMO:MPOD:02"	\
	-m "IOC=TMO:MPOD:02:IOC"	\
	-m "TITLE=ioc-tmo-mpod02"	\
	-m "HUTCH=tmo"	\
	-m "MOD0=TMO:MPOD:02"	\
	-m "MOD1=TMO:MPOD:02"	\
	-m "MOD2=TMO:MPOD:02"	\
	-m "MOD3=TMO:MPOD:02"	\
	-m "MOD4=TMO:MPOD:02"	\
	-m "MOD5=TMO:MPOD:02"	\
	-m "MOD6=TMO:MPOD:02"	\
	-m "MOD7=TMO:MPOD:02"	\
	-m "MOD8=TMO:MPOD:02"	\
	-m "MOD9=TMO:MPOD:02"	\
	isegPowerScreens/ioc-tmo-mpod02.edl  &


