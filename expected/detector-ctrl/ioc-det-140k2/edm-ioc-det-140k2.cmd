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
  -m PRE=DET:140K:2:04 \
  -m PREM=DET:MBL2 \
  -m DLVCHN=100 \
  -m ALVCHN=101 \
  -m HVCHN=204 \
  -m NMOD=\'\' \
    detector-ctrlScreens/det_140k_ctrl.edl &
edm -x -eolc \
  -m PRE=DET:140K:2:06 \
  -m PREM=DET:MBL2 \
  -m DLVCHN=104 \
  -m ALVCHN=105 \
  -m HVCHN=206 \
  -m NMOD=\'\' \
    detector-ctrlScreens/det_140k_ctrl.edl &
edm -x -eolc \
  -m PRE=DET:140K:2:07 \
  -m PREM=DET:MBL2 \
  -m DLVCHN=106 \
  -m ALVCHN=107 \
  -m HVCHN=207 \
  -m NMOD=\'\' \
    detector-ctrlScreens/det_140k_ctrl.edl &


