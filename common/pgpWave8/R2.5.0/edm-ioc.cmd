#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh

export IOC_PV=$$IOC_PV
export PGP_PV=$$IF(PGP_PV,$$PGP_PV,PgpUnknown)
export PGP_PY=$$IF(PGP_PY,$$PGP_PY,PgpPyUnk)
export TRIG_CH=$$IF(PGP_LANE,$$PGP_LANE,0)
export HUTCH=$$IF(HUTCH,$$HUTCH,tst)


EDM_TOP=pgpWave8Screens/pgpWave8Top.edl
$$IF(SCREENS_TOP)
SCREENS_TOP=$$SCREENS_TOP
$$ELSE(SCREENS_TOP)
SCREENS_TOP=${EPICS_SITE_TOP}-dev/screens/edm/${HUTCH}/current
$$ENDIF(SCREENS_TOP)

pushd $$IOCTOP/screenLinks
edm -x -eolc	\
	-m "IOC=${IOC_PV}"			\
	-m "PGP=${PGP_PV}"			\
	-m "PGP_PY=${PGP_PY}"			\
	-m "CH=${TRIG_CH}"			\
	-m "EDM_TOP=${EDM_TOP}"		\
	-m "HUTCH=${HUTCH}"			\
	${EDM_TOP} &

