#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=IOC:LAS:TEM:01

# Setup pydm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
source /cds/group/pcds/pyps/conda/py36env.sh
pushd /cds/group/pcds/epics/ioc/common/TEM_PhaseLock/R1.0.1

export TOP_SCREEN=screens/TEM_PhaseLock.ui
pydm -m "BASE=LAS:TEM:01" ${TOP_SCREEN} &
