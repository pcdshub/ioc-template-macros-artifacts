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

pushd /reg/g/pcds/epics/ioc/common/epix/R1.5.1
edm -x -eolc	\
  -m PREM=MFX:DET  \
  -m DLVCHN=201 \
  -m ALVCHN=200 \
  -m PLVCHN=204 \
  -m HVCHN=004 \
  -m PRE=MFX:EPIX \
  -m NMOD=:01 \
	epixScreens/det_epix_ctrl.edl &
edm -x -eolc	\
  -m PREM=MFX:DET  \
  -m DLVCHN=203 \
  -m ALVCHN=202 \
  -m PLVCHN=205 \
  -m HVCHN=005 \
  -m PRE=MFX:EPIX \
  -m NMOD=:02 \
	epixScreens/det_epix_ctrl.edl &

