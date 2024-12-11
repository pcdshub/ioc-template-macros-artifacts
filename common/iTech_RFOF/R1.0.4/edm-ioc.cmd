#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
        source /reg/g/pcds/pyps/config/common_dirs.sh
else
        source /afs/slac/g/pcds/config/common_dirs.sh
fi

export EPICS_HOST_ARCH="rhel7-x86_64" # fix for env var overwritten by pcds_conda
export IOC_PV=$$IOC_PV

# Setup pydm environment
source /cds/group/pcds/pyps/conda/pcds_conda
pushd $$RELEASE


echo "Launching rfof.ui"
export BASE=$$BASE
pydm --hide-nav-bar    \
        -m "IOC=${IOC_PV}"                      \
        -m "BASE=${BASE}"                       \
         rfofScreens/rfof.ui  &
