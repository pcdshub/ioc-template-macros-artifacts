#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
        source /reg/g/pcds/pyps/config/common_dirs.sh
else
        source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=IOC:UED:USR:TCT:02

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /reg/g/pcds/epics/ioc/common/lakeshore336/R2.2.3

echo "Launching lakeshore 336 screen"
export TCT=UED:USR:TCT:02
edm -x -eolc    \
        -m "DEV=${TCT}"			\
        -m "IOC=${IOC_PV}"                      \
         ls336Screens/lakeshore336.edl &
