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

pushd $$IOCTOP

export MPOD_EDMS="/cds/group/pcds/epics/ioc/common/mpod/R2.2.11"
export CTR_EDMS="/cds/group/pcds/epics/ioc/common/concentrator/R1.1.0"
export EDMDATAFILES=".:..:${MPOD_EDMS}:${CTR_EDMS}"

$$LOOP(CSPAD)
$$IF(CTR)
edm -x -eolc \
  -m PRED=$$NAME \
  -m PRE=$$(MPOD):MPD \
  -m CFG=$$MCFG \
  -m CTR=$$CTR \
  -m LOC=$$LOCATION \
  -m ADLVMOD=$$IF(ADLVMOD,$$ADLVMOD,\'\') \
  -m HVMOD=$$IF(HVMOD,$$HVMOD,\'\') \
    detector-ctrlScreens/CSpad_ctrl_ctr.edl &
$$ELSE(CTR)
edm -x -eolc \
  -m PRED=$$NAME \
  -m PRE=$$(MPOD):MPD \
  -m CFG=$$MCFG \
  -m LOC=$$LOCATION \
  -m MPC=$$(CMOD)2 \
  -m ADLVMOD=$$IF(ADLVMOD,$$ADLVMOD,\'\') \
  -m HVMOD=$$IF(HVMOD,$$HVMOD,\'\') \
    detector-ctrlScreens/CSpad_ctrl.edl &
$$ENDIF(CTR)
$$ENDLOOP(CSPAD)

$$LOOP(CSPAD140k)
edm -x -eolc \
  -m PRE=$$NAME \
  -m PREM=$$(MPOD) \
  -m DLVCHN=$$DLVCHN \
  -m ALVCHN=$$ALVCHN \
  -m HVCHN=$$HVCHN \
  -m NMOD=\'\' \
    detector-ctrlScreens/det_140k_ctrl.edl &
$$ENDLOOP(CSPAD140k)

$$LOOP(EPIX)
edm -x -eolc \
  -m PRE=$$NAME \
  -m PREM=$$(MPOD) \
  -m DLVCHN=$$DLVCHN \
  -m ALVCHN=$$ALVCHN \
  -m PLVCHN=$$PLVCHN \
  -m HVCHN=$$HVCHN \
  -m NMOD=\'\' \
    detector-ctrlScreens/det_epix_ctrl.edl &
$$ENDLOOP(EPIX)

