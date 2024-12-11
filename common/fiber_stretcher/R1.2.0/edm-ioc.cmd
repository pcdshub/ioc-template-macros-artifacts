#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=$$IOC_PV

# Setup environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
source /cds/group/pcds/pyps/conda/py36env.sh
pushd $$RELEASE

$$LOOP(DEVICE)
export TOP_SCREEN=screens/fiber_stretcher_top.ui

pydm -m "BASE=$$BASE,PHASEV=$$PHASEV,LOOP=PID" ${TOP_SCREEN}  & 
#pydm -m "BASE=$$BASE,PHASEV=$$PHASEV" ${TOP_SCREEN}  & 

$$ENDLOOP(DEVICE)
