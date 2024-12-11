#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=EM2K0:XGMD:SHV:01:IOC
export HUTCH=kfe

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /cds/group/pcds/epics/ioc/common/isegPower/R1.3.2

# Launch edm

edm -x -eolc	\
	-m "DEV=EM2K0:XGMD:SHV:01"	\
	-m "IOC=EM2K0:XGMD:SHV:01:IOC"	\
	-m "TITLE=ioc-kfe-mpod-gmd-xgmd"	\
	-m "HUTCH=kfe"	\
	-m "MOD0=EM2K0:XGMD:SHV:01"	\
	isegPowerScreens/mpod4SlotCrate.edl  &


