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

echo "Launching lakeshore 336 screen"
$$LOOP(LAKESHORE)
export TCT=$$NAME
edm -x -eolc    \
        -m "DEV=${TCT}"			\
        -m "IOC=${IOC_PV}"                      \
         ls336Screens/lakeshore336.edl &
$$ENDLOOP(LAKESHORE)
