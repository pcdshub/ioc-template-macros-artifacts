#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=IOC:CRIX:SPC:01

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /reg/g/pcds/epics/ioc/common/OceanOpticsSpectrometer/R1.0.4

export TOP_SCREEN="screens/oceanSTS.edl"
edm -x -eolc	\
	-m "IOC=IOC:CRIX:SPC:01"	\
	-m "P=CRIX:SPC:01"	\
	${TOP_SCREEN}  &
