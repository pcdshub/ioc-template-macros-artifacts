#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=$$IOC_PV

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd $$RELEASE

source /cds/group/pcds/pyps/conda/py36env.sh

$$LOOP(SMA)
export TOP_SCREEN=rssmx100xScreens/rssma100x.ui
pydm -m "BASE=$$BASE,IOC=$$IOC_PV" ${TOP_SCREEN} & 
$$ENDLOOP(SMA)
