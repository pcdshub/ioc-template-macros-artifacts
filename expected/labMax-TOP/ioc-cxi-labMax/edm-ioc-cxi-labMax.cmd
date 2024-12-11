#! /bin/bash

# Setup the common directory env variables
if [ -e      /reg/g/pcds/pyps/config/common_dirs.sh ]; then
        source   /reg/g/pcds/pyps/config/common_dirs.sh
elif [ -e    /afs/slac/g/pcds/pyps/config/common_dirs.sh ]; then
        source   /afs/slac/g/pcds/pyps/config/common_dirs.sh
fi

# Setup edm environment
if [ -f    ${SETUP_SITE_TOP}/epicsenv-cur.sh ]; then
        source ${SETUP_SITE_TOP}/epicsenv-cur.sh
fi

export IOC_PV=CXI:EXP:IOC:LEM
export P=CXI:EXP:IOC:LEM

# Now launching edm from new screenLinks directory under each IOCTOP release
# so each ioc can have it's own custom set of screens that matches which
# set of module depedencies that ioc was built with.
pushd /reg/g/pcds/epics/ioc/common/labMax-TOP/R1.8.2
edm -x -eolc    \
        -m "IOC=${IOC_PV}"              \
        -m "P=${P}"                     \
        labMax-TopScreens/labMax-Top.edl &
