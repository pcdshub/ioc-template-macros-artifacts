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

pushd /cds/group/pcds/epics/ioc/common/epix/R1.5.0
edm -x -eolc	\
  -m PREM=DET:MBL2  \
  -m DLVCHN=201 \
  -m ALVCHN=200 \
  -m PLVCHN=204 \
  -m HVCHN=04 \
  -m PRE=DET:MBL2:EPIX \
  -m NMOD=:01 \
	epixScreens/det_epix_ctrl.edl &
edm -x -eolc	\
  -m PREM=DET:MBL2  \
  -m DLVCHN=203 \
  -m ALVCHN=202 \
  -m PLVCHN=205 \
  -m HVCHN=05 \
  -m PRE=DET:MBL2:EPIX \
  -m NMOD=:02 \
	epixScreens/det_epix_ctrl.edl &

