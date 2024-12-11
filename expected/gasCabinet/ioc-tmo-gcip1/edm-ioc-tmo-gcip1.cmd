#! /bin/bash

# Setup the common directory env variables
if [ -e      /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source   /reg/g/pcds/pyps/config/common_dirs.sh
elif [ -e    /afs/slac/g/pcds/pyps/config/common_dirs.sh ]; then
	source   /afs/slac/g/pcds/pyps/config/common_dirs.sh
fi

# Setup edm environment
source /reg/g/pcds/pyps/conda/py36env.sh

pushd /reg/g/pcds/epics/ioc/common/gasCabinet/R1.0.1/hpm900Screens

pydm -m "DEV=TMO:IP1:HAZ,IOC=IOC:TMO:IP1:GC" gasCabinet.ui &
pydm -m "DEV=TMO:IP1:NONHAZ,IOC=IOC:TMO:IP1:GC" gasCabinet_onepanel.ui &
