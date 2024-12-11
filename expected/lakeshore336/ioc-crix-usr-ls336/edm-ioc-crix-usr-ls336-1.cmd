#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
        source /reg/g/pcds/pyps/config/common_dirs.sh
else
        source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=IOC:CRIX:USR:TCT
export HUTCH=rix

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /reg/g/pcds/epics-dev/spencera/rix/lakeshore336/current

# Launch edm
edm -x -eolc    \
        -m "DEV=CRIX:USR:TCT:01"    \
        -m "IOC=IOC:CRIX:USR:TCT"        \
        -m "HUTCH=rix"  \
         ls336Screens/lakeshore336.edl  &
