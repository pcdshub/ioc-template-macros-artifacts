#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh

export IOC_PV=IOC:XPP:SB3:W82
export PGP_PV=XPP:SB3:W82
export PGP_PY=XPP:SB3:W82
export TRIG_CH=4
export HUTCH=xpp


EDM_TOP=pgpWave8Screens/pgpWave8Top.edl
SCREENS_TOP=${EPICS_SITE_TOP}-dev/screens/edm/${HUTCH}/current

pushd /cds/group/pcds/epics/ioc/common/pgpWave8/R2.5.0/screenLinks
edm -x -eolc	\
	-m "IOC=${IOC_PV}"			\
	-m "PGP=${PGP_PV}"			\
	-m "PGP_PY=${PGP_PY}"			\
	-m "CH=${TRIG_CH}"			\
	-m "EDM_TOP=${EDM_TOP}"		\
	-m "HUTCH=${HUTCH}"			\
	${EDM_TOP} &

