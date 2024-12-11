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
  -m PREM=CXI:D51  \
  -m DLVCHN=200 \
  -m ALVCHN=201 \
  -m PLVCHN=204 \
  -m HVCHN=004 \
  -m PRE=CXI:D51:EPIX \
  -m NMOD=:01 \
	epixScreens/det_epix_ctrl.edl &
edm -x -eolc	\
  -m PREM=CXI:D51  \
  -m DLVCHN=202 \
  -m ALVCHN=203 \
  -m PLVCHN=205 \
  -m HVCHN=005 \
  -m PRE=CXI:D51:EPIX \
  -m NMOD=:02 \
	epixScreens/det_epix_ctrl.edl &
edm -x -eolc	\
  -m PREM=CXI:D51  \
  -m DLVCHN=104 \
  -m ALVCHN=105 \
  -m PLVCHN=206 \
  -m HVCHN=002 \
  -m PRE=CXI:D51:EPIX \
  -m NMOD=:03 \
	epixScreens/det_epix_ctrl.edl &
edm -x -eolc	\
  -m PREM=CXI:D51  \
  -m DLVCHN=106 \
  -m ALVCHN=107 \
  -m PLVCHN=207 \
  -m HVCHN=003 \
  -m PRE=CXI:D51:EPIX \
  -m NMOD=:04 \
	epixScreens/det_epix_ctrl.edl &

