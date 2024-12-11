#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=IOC:RIX:PWR:R02:01
export HUTCH=RIX

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd /reg/g/pcds/epics/ioc/common/pdu_snmp/R2.4.5

# Launch edm

export TOP_SCREEN=`echo pduScreens/emb-Sentry4_24.edl`
edm -x -eolc	\
	-m "IOC=IOC:RIX:PWR:R02:01"	\
	-m "HUTCH=RIX"	\
	-m "PRE=RIX:PWR:R02:01"	\
	${TOP_SCREEN}  &

