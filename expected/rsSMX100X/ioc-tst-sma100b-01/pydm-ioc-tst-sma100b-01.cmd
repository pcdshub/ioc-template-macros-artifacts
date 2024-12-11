#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=IOC:LAS:FTL:SGN:01

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /cds/group/pcds/epics/ioc/common/rsSMX100X/R1.0.0

source /cds/group/pcds/pyps/conda/py36env.sh

export TOP_SCREEN=rssmx100xScreens/rssma100x.ui
pydm -m "BASE=LAS:FTL:SGN:01,IOC=IOC:LAS:FTL:SGN:01" ${TOP_SCREEN} & 
