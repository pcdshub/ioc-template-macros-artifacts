#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh

export IOC_PV=IM0K0:IOC:ROGUE1
export AXI_PV=IM0K0:PGP:ROGUE1
export HUTCH=kfe


AXI_TOP=axiRogueScreens/axiRogueTop.edl
SCREENS_TOP=${EPICS_SITE_TOP}-dev/screens/edm/${HUTCH}/current

#pushd ${SCREENS_TOP}
# Now launching edm from new screenLinks directory under each IOCTOP release
# so each ioc can have it's own custom set of screens that matches which
# set of module depedencies that ioc was built with. 
pushd /reg/g/pcds/epics/ioc/common/axiRogue/R0.2.1/screenLinks
edm -x -eolc	\
	-m "IOC=${IOC_PV}"			\
	-m "AXI=${AXI_PV}"			\
	-m "P=${AXI_PV},R=:"		\
	-m "AXI_TOP=${AXI_TOP}"		\
	-m "HUTCH=${HUTCH}"			\
	${AXI_TOP} &

