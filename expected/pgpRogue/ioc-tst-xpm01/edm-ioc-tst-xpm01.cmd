#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh

export IOC_PV=TST:IOC:PGP:01
export PGP_PV=TST:PGP:01
export HUTCH=tst


PGP_TOP=pgpRogueScreens/pgpRogueTop.edl
SCREENS_TOP=${EPICS_SITE_TOP}-dev/screens/edm/${HUTCH}/current

#pushd ${SCREENS_TOP}
# Now launching edm from new screenLinks directory under each IOCTOP release
# so each ioc can have it's own custom set of screens that matches which
# set of module depedencies that ioc was built with. 
pushd /cds/group/pcds/epics/ioc/common/pgpRogue/R0.5.0/screenLinks
edm -x -eolc	\
	-m "IOC=${IOC_PV}"			\
	-m "PGP=${PGP_PV}"			\
	-m "P=${PGP_PV},R=:"		\
	-m "PGP_TOP=${PGP_TOP}"		\
	-m "HUTCH=${HUTCH}"			\
	${PGP_TOP} &

