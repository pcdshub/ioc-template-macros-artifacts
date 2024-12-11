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
  -m PREM=XPP:ALC  \
  -m DLVCHN=201 \
  -m ALVCHN=200 \
  -m PLVCHN=204 \
  -m HVCHN=4 \
  -m PRE=XPP:ALC:EPIX \
  -m NMOD=:01 \
	epixScreens/det_epix_ctrl.edl &
edm -x -eolc	\
  -m PREM=XPP:ALC  \
  -m DLVCHN=203 \
  -m ALVCHN=202 \
  -m PLVCHN=205 \
  -m HVCHN=5 \
  -m PRE=XPP:ALC:EPIX \
  -m NMOD=:02 \
	epixScreens/det_epix_ctrl.edl &
edm -x -eolc	\
  -m PREM=XPP:ALC  \
  -m DLVCHN=105 \
  -m ALVCHN=104 \
  -m PLVCHN=206 \
  -m HVCHN=2 \
  -m PRE=XPP:ALC:EPIX \
  -m NMOD=:03 \
	epixScreens/det_epix_ctrl.edl &
edm -x -eolc	\
  -m PREM=XPP:ALC  \
  -m DLVCHN=107 \
  -m ALVCHN=106 \
  -m PLVCHN=207 \
  -m HVCHN=3 \
  -m PRE=XPP:ALC:EPIX \
  -m NMOD=:04 \
	epixScreens/det_epix_ctrl.edl &

