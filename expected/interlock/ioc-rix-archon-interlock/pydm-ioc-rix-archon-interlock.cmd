#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
        source /reg/g/pcds/pyps/config/common_dirs.sh
else
        source /afs/slac/g/pcds/config/common_dirs.sh
fi

export EPICS_HOST_ARCH="rhel7-x86_64" # fix for env var overwritten by pcds_conda
export IOC_PV=IOC:ILK:QRIXS:DET

# Setup pydm environment
source /cds/group/pcds/pyps/conda/pcds_conda
pushd /reg/g/pcds/epics/ioc/common/interlock/R1.0.0

#
pydm --hide-nav-bar -m "IOC=IOC:ILK:QRIXS:DET","R0=", interlockScreens/interlock.py &

