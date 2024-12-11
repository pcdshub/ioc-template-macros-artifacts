#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
        source /reg/g/pcds/pyps/config/common_dirs.sh
else
        source /afs/slac/g/pcds/config/common_dirs.sh
fi

export EPICS_HOST_ARCH="rhel7-x86_64" # fix for env var overwritten by pcds_conda
export IOC_PV=XPP:LC20:IOC:01

# Setup pydm environment
source /cds/group/pcds/pyps/conda/pcds_conda
pushd /reg/g/pcds/epics/ioc/common/shimadzu-lc20/R1.3.6

echo "Launching screens for all HPLCs in st.cmd file. For individual screens, please use a custom script"
export DEV=XPP:SDS:LC20:01
pydm --hide-nav-bar    \
        -m "DEV=${DEV}","IOC=${IOC_PV}"                      \
         lc20Screens/lc20.py &
export DEV=XPP:SDS:LC20:02
pydm --hide-nav-bar    \
        -m "DEV=${DEV}","IOC=${IOC_PV}"                      \
         lc20Screens/lc20.py &
export DEV=XPP:SDS:LC20:03
pydm --hide-nav-bar    \
        -m "DEV=${DEV}","IOC=${IOC_PV}"                      \
         lc20Screens/lc20.py &
export DEV=XPP:SDS:LC20:04
pydm --hide-nav-bar    \
        -m "DEV=${DEV}","IOC=${IOC_PV}"                      \
         lc20Screens/lc20.py &

