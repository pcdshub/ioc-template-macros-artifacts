#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=TST:MPOD:IOC
export HUTCH=tst

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /cds/group/pcds/epics/ioc/common/isegPower/R1.3.2

# Launch edm

edm -x -eolc	\
	-m "DEV=TST:MPOD:01"	\
	-m "IOC=TST:MPOD:IOC"	\
	-m "TITLE=ioc-tst-mpod-wiener"	\
	-m "HUTCH=tst"	\
	-m "MOD0=TST:MPOD:01"	\
	-m "MOD1=TST:MPOD:01"	\
	-m "MOD2=TST:MPOD:01"	\
	isegPowerScreens/mpod4SlotCrate.edl  &


