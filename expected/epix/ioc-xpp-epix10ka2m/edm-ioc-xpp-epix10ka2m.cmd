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
  -m PREM=XPP:DET  \
  -m Q0_DLV=1 \
  -m Q0_ALV=0 \
  -m Q0_HV=200 \
  -m Q1_DLV=3 \
  -m Q1_ALV=2 \
  -m Q1_HV=201 \
  -m Q2_DLV=5 \
  -m Q2_ALV=4 \
  -m Q2_HV=202 \
  -m Q3_DLV=7 \
  -m Q3_ALV=6 \
  -m Q3_HV=203 \
  -m PRE=XPP:EPIX2M \
  -m NMOD=:01 \
-m CHBASE=XPP:ROB:TTK:01 -m CHIOC=IOC:XPP:TTK:01  \
	epixScreens/det_epix2m_ctrl.edl &
