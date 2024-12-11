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

export CAM=IM1K4:XTES:CAM
export IOC_PV=IM1K4:XTES:CAM:IOC
export PGP_PV=IM0K0:PGP:ROGUE1
export PGP_IOC=IM0K0:IOC:ROGUE1
export CAM_NAME="IM1K4"
export TRIG_CH=2
export HUTCH=kfe
export TOP=/reg/g/pcds/epics/ioc/common/pgpCamlink/R1.7.1
if [ ! -d $TOP ]; then
	if [ -d $EPICS_IOCS/ioc-kfe-pgp03/iocSpecificRelease/iocBoot ]; then
		export TOP=`readlink -f $EPICS_IOCS/ioc-kfe-pgp03/iocSpecificRelease/`
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

