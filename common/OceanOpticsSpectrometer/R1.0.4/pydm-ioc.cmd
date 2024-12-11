#! /bin/bash

source pcds_conda

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=$$IOC_PV

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd $$RELEASE

$$LOOP(DEVICE)
export TOP_SCREEN="screens/oceanSTS.py"
pydm --hide-nav-bar -m "P=$$BASE" ${TOP_SCREEN}  &
$$ENDLOOP(DEVICE)
