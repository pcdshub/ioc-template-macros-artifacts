#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
        source /reg/g/pcds/pyps/config/common_dirs.sh
else
        source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=$$IOC_PV

pushd $$RELEASE
source pcds_conda

$$LOOP(DEVICE)
export TOP_SCREEN=screens/isegfps.ui

pydm -m "BASE=$$BASE" $TOP_SCREEN &
$$ENDLOOP(DEVICE)
