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
  -m PRED=DET:CSPAD \
  -m PRE=DET:MBL:MPD \
  -m CFG=three-modules-llh \
  -m CTR=DET:MBL:01:CTR \
  -m LOC=DET:CSPAD \
  -m ADLVMOD=\'\' \
  -m HVMOD=20 \
    detector-ctrlScreens/CSpad_ctrl_ctr.edl &



