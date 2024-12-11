#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
        source /reg/g/pcds/pyps/config/common_dirs.sh
else
        source /afs/slac/g/pcds/config/common_dirs.sh
fi

export PCDS_CONDA_VER=5.7.3
source /cds/group/pcds/pyps/conda/pcds_conda


export IOC_PV=$$IOC_PV

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
#pushd /reg/g/pcds/epics-dev/ljansen7/ioc/las/SDG_Elite
pushd $$RELEASE 
#
$$LOOP(DEVICE)
export TOP_SCREEN=SDG_Screens/SDG_ioc.ui
pydm    \
        -m "IOC=$$IOC_PV" \
        -m "BASE=$$BASE"    \
        ${TOP_SCREEN}  &
$$ENDLOOP(DEVICE)
