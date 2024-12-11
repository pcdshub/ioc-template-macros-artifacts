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
$$LOOP(EPIX)
edm -x -eolc	\
  -m PREM=$$MPOD  \
  -m DLVCHN=$$DLV \
  -m ALVCHN=$$ALV \
  -m PLVCHN=$$IF(PLV,$$PLV,None) \
  -m HVCHN=$$HV \
  -m PRE=$$BASE \
  -m NMOD=:$$NAME \
	epixScreens/det_epix_ctrl.edl &
$$ENDLOOP(EPIX)

$$LOOP(EPIX2M)
edm -x -eolc	\
  -m PREM=$$MPOD  \
  -m Q0_DLV=$$Q0_DLV \
  -m Q0_ALV=$$Q0_ALV \
  -m Q0_HV=$$Q0_HV \
  -m Q1_DLV=$$Q1_DLV \
  -m Q1_ALV=$$Q1_ALV \
  -m Q1_HV=$$Q1_HV \
  -m Q2_DLV=$$Q2_DLV \
  -m Q2_ALV=$$Q2_ALV \
  -m Q2_HV=$$Q2_HV \
  -m Q3_DLV=$$Q3_DLV \
  -m Q3_ALV=$$Q3_ALV \
  -m Q3_HV=$$Q3_HV \
  -m PRE=$$BASE \
  -m NMOD=:$$NAME \
$$LOOP(CHILLER)-m CHBASE=$$CH -m CHIOC=$$IOC $$ENDLOOP(CHILLER) \
	epixScreens/det_epix2m_ctrl.edl &
$$ENDLOOP(EPIX2M)
