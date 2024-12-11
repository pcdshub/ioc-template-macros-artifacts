#! /bin/bash

# Setup the common directory env variables
if [ -e      /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source   /reg/g/pcds/pyps/config/common_dirs.sh
elif [ -e    /afs/slac/g/pcds/pyps/config/common_dirs.sh ]; then
	source   /afs/slac/g/pcds/pyps/config/common_dirs.sh
fi

# Setup edm environment
if [ -f    ${SETUP_SITE_TOP}/epicsenv-cur.sh ]; then
	source ${SETUP_SITE_TOP}/epicsenv-cur.sh
fi

source /cds/group/pcds/pyps/conda/py36env.sh

pushd /cds/group/pcds/epics/ioc/common/qadc/R2.3.0/qadcScreens

export IOC_PV=IOC:CXI:QADC:02

python -m main --lcls1 --prefix CXI:QADC:02 >& /dev/null &
