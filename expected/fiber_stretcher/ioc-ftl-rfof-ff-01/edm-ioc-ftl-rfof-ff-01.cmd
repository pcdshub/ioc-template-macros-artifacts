#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=IOC:LAS:FTL:RFOF:FF:01

# Setup environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
source /cds/group/pcds/pyps/conda/py36env.sh
pushd /cds/group/pcds/epics/ioc/common/fiber_stretcher/R1.2.0

export TOP_SCREEN=screens/fiber_stretcher_top.ui

pydm -m "BASE=LAS:FTL:RFOF:FF:01,PHASEV=LAS:FTL:BHC:01:AI1:3,LOOP=PID" ${TOP_SCREEN}  & 
#pydm -m "BASE=LAS:FTL:RFOF:FF:01,PHASEV=LAS:FTL:BHC:01:AI1:3" ${TOP_SCREEN}  & 

