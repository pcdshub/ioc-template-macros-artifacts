#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
        source /reg/g/pcds/pyps/config/common_dirs.sh
else
        source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=IOC:TMO:FPS:01

pushd /reg/g/pcds/epics/ioc/common/isegFPS/R1.0.1
source pcds_conda

export TOP_SCREEN=screens/isegfps.ui

pydm -m "BASE=TMO:FPS:01" $TOP_SCREEN &
