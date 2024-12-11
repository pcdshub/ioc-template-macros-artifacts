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
  -m Q0_DLV=101 \
  -m Q0_ALV=100 \
  -m Q0_HV=00 \
  -m Q1_DLV=103 \
  -m Q1_ALV=102 \
  -m Q1_HV=01 \
  -m Q2_DLV=105 \
  -m Q2_ALV=104 \
  -m Q2_HV=02 \
  -m Q3_DLV=107 \
  -m Q3_ALV=106 \
  -m Q3_HV=03 \
  -m PRE=DET:MBL2:EPIX2M \
  -m NMOD=:01 \
-m CHBASE=DET:TTK:03 -m CHIOC=IOC:DET:TTK:03  \
	epixScreens/det_epix2m_ctrl.edl &
