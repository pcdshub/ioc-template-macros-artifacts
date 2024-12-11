#! /bin/bash

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

$$LOOP(SMARACT)
export TOP_SCREEN=`echo motorScreens/mcs2_tile$$COUNT.edl`
edm -x -eolc    \
        -m "IOC=$$IOC_PV"       \
        -m "MOTOR=$$BASE"   \
        ${TOP_SCREEN}  &
$$ENDLOOP(SMARACT)
