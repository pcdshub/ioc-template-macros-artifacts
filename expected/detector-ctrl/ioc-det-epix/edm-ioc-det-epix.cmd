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

pushd /reg/g/pcds/epics/ioc/common/detector-ctrl/R3.3.0

export MPOD_EDMS="/cds/group/pcds/epics/ioc/common/mpod/R2.2.11"
export CTR_EDMS="/cds/group/pcds/epics/ioc/common/concentrator/R1.1.0"
export EDMDATAFILES=".:..:${MPOD_EDMS}:${CTR_EDMS}"



edm -x -eolc \
  -m PRE=DET:EPIX:01 \
  -m PREM=DET:MBL \
  -m DLVCHN=0 \
  -m ALVCHN=1 \
  -m PLVCHN=2 \
  -m HVCHN=200 \
  -m NMOD=\'\' \
    detector-ctrlScreens/det_epix_ctrl.edl &
edm -x -eolc \
  -m PRE=DET:EPIX:02 \
  -m PREM=DET:MBL \
  -m DLVCHN=4 \
  -m ALVCHN=5 \
  -m PLVCHN=3 \
  -m HVCHN=202 \
  -m NMOD=\'\' \
    detector-ctrlScreens/det_epix_ctrl.edl &
edm -x -eolc \
  -m PRE=DET:EPIX:03 \
  -m PREM=DET:MBL \
  -m DLVCHN=100 \
  -m ALVCHN=101 \
  -m PLVCHN=104 \
  -m HVCHN=204 \
  -m NMOD=\'\' \
    detector-ctrlScreens/det_epix_ctrl.edl &
edm -x -eolc \
  -m PRE=DET:EPIX:04 \
  -m PREM=DET:MBL \
  -m DLVCHN=106 \
  -m ALVCHN=107 \
  -m PLVCHN=105 \
  -m HVCHN=207 \
  -m NMOD=\'\' \
    detector-ctrlScreens/det_epix_ctrl.edl &

