#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=IOC:TMO:PWR:R02
export HUTCH=TMO

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /reg/g/pcds/epics/ioc/common/pdu_snmp/R2.4.4

# Launch edm

export TOP_SCREEN=`echo pduScreens/emb-Sentry4_8.edl`
edm -x -eolc	\
	-m "IOC=IOC:TMO:PWR:R02"	\
	-m "HUTCH=TMO"	\
	-m "PRE=TMO:PWR:R02:01"	\
	${TOP_SCREEN}  &

