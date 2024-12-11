#! /bin/bash

# Setup the common directory env variables
if [ -e    /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
elif [ -e  /usr/local/lcls/epics/config/common_dirs.sh ]; then
	source /usr/local/lcls/epics/config/common_dirs.sh
else
	source /afs/slac/g/lcls/epics/config/common_dirs.sh
fi

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh

export CAM=$$CAM_PV
export IOC_PV=$$IOC_PV
export PGP_PV=$$IF(PGP_PV,$$PGP_PV,PgpUnknown)
export PGP_IOC=$$IF(PGP_IOC,$$PGP_IOC,PgpIocUnk)
export CAM_NAME="$$IF(CAM_NAME,$$CAM_NAME,Unnamed)"
export TRIG_CH=$$IF(PGP_LANE,$$PGP_LANE,0)
export HUTCH=$$IF(HUTCH,$$HUTCH,tst)
export TOP=$$IOCTOP
if [ ! -d $TOP ]; then
	if [ -d $EPICS_IOCS/$$IOCNAME/iocSpecificRelease/iocBoot ]; then
		export TOP=`readlink -f $EPICS_IOCS/$$IOCNAME/iocSpecificRelease/`
	fi
fi

EDM_TOP=pgpCamlinkScreens/pgpCamTop.edl

# Now launching edm from new screenLinks directory under each IOCTOP release
# so each ioc can have it's own custom set of screens that matches which
# set of module depedencies that ioc was built with. 
pushd $TOP/screenLinks
edm -x -eolc	\
	-m "IOC=${IOC_PV}"			\
	-m "PGP=${PGP_PV}"			\
	-m "PGP_IOC=${PGP_IOC}"		\
	-m "CAM=${CAM}"				\
	-m "CAM_NAME=${CAM_NAME}"	\
	-m "CH=${TRIG_CH}"			\
	-m "P=${CAM},R=:"			\
	-m "EDM_TOP=${EDM_TOP}"		\
	-m "HUTCH=${HUTCH}"			\
	${EDM_TOP} &

