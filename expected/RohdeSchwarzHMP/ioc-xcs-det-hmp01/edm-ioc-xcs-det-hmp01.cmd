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

pushd /cds/group/pcds/epics/ioc/common/RohdeSchwarzHMP/R1.2.1
edm -x -eolc    \
  -m DEV=XCS:DET:HMP:01 \
  -m DESC=HMP4030   \
  -m IOC=IOC:XCS:DET:HMP:01   \
    rshmpScreens/hmp4030.edl &