#! /bin/bash

# Setup the common directory env variables
if [ -e      /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source   /reg/g/pcds/pyps/config/common_dirs.sh
elif [ -e    /afs/slac/g/pcds/pyps/config/common_dirs.sh ]; then
	source   /afs/slac/g/pcds/pyps/config/common_dirs.sh
fi

# Setup edm environment
source /reg/g/pcds/pyps/conda/py36env.sh

pushd /reg/g/pcds/epics/ioc/common/thermocon/R2.0.0/thermoconScreens

export IOC_PV=IOC:MR2K2:FLAT:CHL
export BASE=MR2K2:FLAT:CHL

pydm -m "DEV=${BASE},IOC=${IOC_PV}" thermocon.ui &
