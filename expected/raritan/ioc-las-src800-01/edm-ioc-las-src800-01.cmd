#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=LAS:IOC:SRC800:01
export HUTCH=

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /cds/group/pcds/epics/ioc/common/raritan/R1.0.1

# Launch edm


