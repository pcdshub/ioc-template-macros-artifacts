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

pushd /reg/g/pcds/epics/ioc/common/epix/R1.5.0
edm -x -eolc	\
  -m PREM=XPP:R39  \
  -m DLVCHN=300 \
  -m ALVCHN=301 \
  -m PLVCHN=302 \
  -m HVCHN=100 \
  -m PRE=XPP:USR:EPIX \
  -m NMOD=:01 \
	epixScreens/det_epix_ctrl.edl &

