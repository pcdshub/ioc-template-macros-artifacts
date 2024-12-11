#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
        source /reg/g/pcds/pyps/config/common_dirs.sh
else
        source /afs/slac/g/pcds/config/common_dirs.sh
fi

export PCDS_CONDA_VER=5.7.3
source /cds/group/pcds/pyps/conda/pcds_conda


export IOC_PV=IOC:LAS:LHN:SDG:01

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
#pushd /reg/g/pcds/epics-dev/ljansen7/ioc/las/SDG_Elite
pushd /reg/g/pcds/epics/ioc/common/SDG_Elite/R1.1.1 
#
export TOP_SCREEN=SDG_Screens/SDG_ioc.ui
pydm    \
        -m "IOC=IOC:LAS:LHN:SDG:01" \
        -m "BASE=LAS:LHN:SDG:01"    \
        ${TOP_SCREEN}  &
