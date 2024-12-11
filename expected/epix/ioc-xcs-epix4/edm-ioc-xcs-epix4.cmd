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
  -m PREM=DET:MBL  \
  -m DLVCHN=7 \
  -m ALVCHN=6 \
  -m PLVCHN=107 \
  -m HVCHN=203 \
  -m PRE=XCS:EPIX \
  -m NMOD=:04 \
	epixScreens/det_epix_ctrl.edl &

