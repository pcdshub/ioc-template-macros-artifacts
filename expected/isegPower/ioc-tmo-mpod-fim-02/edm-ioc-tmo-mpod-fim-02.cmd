#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=TMO:MPOD:FIM:IOC:02
export HUTCH=tmo

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /cds/group/pcds/epics/ioc/common/isegPower/R1.3.2

# Launch edm

edm -x -eolc	\
	-m "DEV=TMO:MPOD:FIM:02"	\
	-m "IOC=TMO:MPOD:FIM:IOC:02"	\
	-m "TITLE=ioc-tmo-mpod-fim-02"	\
	-m "HUTCH=tmo"	\
	-m "MOD0=MR9K8:FIM:SHV"	\
	-m "MOD1=MR9K9:FIM:SHV"	\
	isegPowerScreens/mpod4SlotCrate.edl  &


