#! /bin/bash

source pcds_conda

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=IOC:UED:SPC:01

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /cds/group/pcds/epics/ioc/common/OceanOpticsSpectrometer/R1.0.4

export TOP_SCREEN="screens/oceanSTS.py"
pydm --hide-nav-bar -m "P=UED:SPC:01" ${TOP_SCREEN}  &
