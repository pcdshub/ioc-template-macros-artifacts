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
  -m PRE=CXI:D50:140K:04 \
  -m PREM=CXI:D50 \
  -m DLVCHN=200 \
  -m ALVCHN=201 \
  -m HVCHN=4 \
  -m NMOD=\'\' \
    detector-ctrlScreens/det_140k_ctrl.edl &
edm -x -eolc \
  -m PRE=CXI:D50:140K:06 \
  -m PREM=CXI:D50 \
  -m DLVCHN=204 \
  -m ALVCHN=205 \
  -m HVCHN=6 \
  -m NMOD=\'\' \
    detector-ctrlScreens/det_140k_ctrl.edl &
edm -x -eolc \
  -m PRE=CXI:D50:140K:07 \
  -m PREM=CXI:D50 \
  -m DLVCHN=206 \
  -m ALVCHN=207 \
  -m HVCHN=7 \
  -m NMOD=\'\' \
    detector-ctrlScreens/det_140k_ctrl.edl &


