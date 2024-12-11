#!/bin/sh
# If we are running this as an IOC, we are *in* this directory!
export SETUP_SITE_TOP=/cds/group/pcds/setup
source $SETUP_SITE_TOP/epicsenv-cur.sh

gwname=ioc-hpl-rfof1
gwprefix=NET:IOC:HPL:RFOF1
cagprogram="/cds/group/pcds/epics/extensions/gateway/R2.1.2.0-1.4.1/bin/$EPICS_HOST_ARCH/gateway"
cagvardir=/reg/d/iocData/ioc-hpl-rfof1/iocInfo
cagcfgdir=`pwd`

export EPICS_CA_BEACON_PERIOD=20.0
export EPICS_CA_CONN_TMO=60.0
export EPICS_CA_MAX_ARRAY_BYTES=40000000
export EPICS_CA_AUTO_ADDR_LIST=NO
export EPICS_CAS_AUTO_BEACON_ADDR_LIST=NO

export EPICS_CA_SERVER_PORT=5064
export EPICS_CAS_SERVER_PORT=5064
export EPICS_PVA_SERVER_PORT=5075
export EPICS_PVA_BROADCAST_PORT=5076
export EPICS_CAS_IGNORE_ADDR_LIST=""
export EPICS_CA_AUTO_ADDR_LIST=NO
export EPICS_CA_ADDR_LIST="192.168.1.255"
export EPICS_CAS_BEACON_ADDR_LIST=`echo 192.168.1.255 | awk '{for (i=1;i<=NF;i++) printf "%s:5065 ", $i;printf "\n";}' -`
export EPICS_CAS_INTF_ADDR_LIST=172.21.64.133
export EPICS_CAS_IGNORE_ADDR_LIST="$EPICS_CAS_IGNORE_ADDR_LIST 172.21.64.133:$EPICS_CA_SERVER_PORT"
cagflags=

echo -n "Starting $1 CA gateway... "
TIME=`date +%Y_%m_%d-%T`
mkdir -p $cagvardir/$gwname
/bin/rm -f $cagvardir/$gwname/gateway-put.log
ln -s $cagvardir/$gwname/gateway-put.log.$TIME $cagvardir/$gwname/gateway-put.log
touch $cagvardir/$gwname/gateway-put.log.$TIME
$cagprogram -access /cds/group/pcds/epics/ioc/common/local_gateway/R1.0.2/pcds-access.acf \
	    -pvlist $cagcfgdir/$gwname.pvlist \
	    -home $cagvardir \
	    -prefix $gwprefix \
	    -command $cagvardir/gateway.command \
	    -putlog $cagvardir/$gwname/gateway-put.log $cagflags
