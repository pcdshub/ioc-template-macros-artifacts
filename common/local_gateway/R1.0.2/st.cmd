#!/bin/sh
# If we are running this as an IOC, we are *in* this directory!
export SETUP_SITE_TOP=/cds/group/pcds/setup
source $SETUP_SITE_TOP/epicsenv-cur.sh

gwname=$$IOCNAME
gwprefix=NET:$$TRANSLATE(IOCNAME,"abcdefghijklmnopqrstuvwxyz-","ABCDEFGHIJKLMNOPQRSTUVWXYZ:")
cagprogram="/cds/group/pcds/epics/extensions/gateway/R2.1.2.0-1.4.1/bin/$EPICS_HOST_ARCH/gateway"
cagvardir=/reg/d/iocData/$$IOCNAME/iocInfo
cagcfgdir=`pwd`

export EPICS_CA_BEACON_PERIOD=20.0
export EPICS_CA_CONN_TMO=60.0
export EPICS_CA_MAX_ARRAY_BYTES=40000000
export EPICS_CA_AUTO_ADDR_LIST=NO
export EPICS_CAS_AUTO_BEACON_ADDR_LIST=NO

export EPICS_CA_SERVER_PORT=$$IF(CA_SERVER_PORT,$$CA_SERVER_PORT,5064)
export EPICS_CAS_SERVER_PORT=$$IF(CAS_SERVER_PORT,$$CAS_SERVER_PORT,5064)
export EPICS_PVA_SERVER_PORT=$$IF(PVA_SERVER_PORT,$$PVA_SERVER_PORT,5075)
export EPICS_PVA_BROADCAST_PORT=$$IF(PVA_BC_PORT,$$PVA_BC_PORT,5076)
export EPICS_CAS_IGNORE_ADDR_LIST=""
export EPICS_CA_AUTO_ADDR_LIST=NO
$$LOOP(GATEWAY)
export EPICS_CA_ADDR_LIST="$$SERVER_BC"
export EPICS_CAS_BEACON_ADDR_LIST=`echo $$SERVER_BC | awk '{for (i=1;i<=NF;i++) printf "%s:$$IF(BEACON_PORT,$$BEACON_PORT,5065) ", $i;printf "\n";}' -`
export EPICS_CAS_INTF_ADDR_LIST=$$REQ_IF
export EPICS_CAS_IGNORE_ADDR_LIST="$EPICS_CAS_IGNORE_ADDR_LIST $$REQ_IF:$EPICS_CA_SERVER_PORT"
cagflags=$$FLAGS
$$ENDLOOP(GATEWAY)

echo -n "Starting $1 CA gateway... "
TIME=`date +%Y_%m_%d-%T`
mkdir -p $cagvardir/$gwname
/bin/rm -f $cagvardir/$gwname/gateway-put.log
ln -s $cagvardir/$gwname/gateway-put.log.$TIME $cagvardir/$gwname/gateway-put.log
touch $cagvardir/$gwname/gateway-put.log.$TIME
$cagprogram -access $$IOCTOP/pcds-access.acf \
	    -pvlist $cagcfgdir/$gwname.pvlist \
	    -home $cagvardir \
	    -prefix $gwprefix \
	    -command $cagvardir/gateway.command \
	    -putlog $cagvardir/$gwname/gateway-put.log $cagflags
