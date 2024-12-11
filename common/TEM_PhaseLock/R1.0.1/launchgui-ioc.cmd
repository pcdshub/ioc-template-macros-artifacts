#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=$$IOC_PV

# Setup pydm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
source /cds/group/pcds/pyps/conda/py36env.sh
pushd $$RELEASE

$$LOOP(DEVICE)
export TOP_SCREEN=screens/TEM_PhaseLock.ui
pydm -m "BASE=$$BASE" ${TOP_SCREEN} &
$$ENDLOOP(DEVICE)
