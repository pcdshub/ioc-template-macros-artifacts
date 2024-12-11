#!/reg/g/pcds/package/epics/3.14/ioc/common/NewportXPS8/R2.0.1/bin/linux-x86_64/xps8

epicsEnvSet( "EPICS_NAME", "IOC:LAS:AMO:XPS3" )
epicsEnvSet( "LOCATION",   "AMO:XXX"  )
epicsEnvSet( "IOCSH_PS1",  "ioc-las-amo-xps3> " )
epicsEnvSet( "ENGINEER",   "Sebastian F. Carron Montero (carron)"  )


< envPaths

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/xps8.dbd" )
xps8_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocAdmin.db",                "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db",      "IOC=$(EPICS_NAME)" )

dbLoadRecords( "$(TOP)/db/status_update_arbitrary.db", "DEVICE=AMO:LAS:MCN3,basePeriod='10 second',multiplier=1" )
dbLoadRecords( "$(TOP)/db/XPS8_arbitrary.db",          "DEVICE=AMO:LAS:MCN3,CTRL=mcn-amo-las3,PORT=5001,POS1=AMO:LAS:MCN3:01,POS2=AMO:LAS:DLS:05:MTR,POS3=AMO:LAS:MIR:08:M8H,POS4=AMO:LAS:MIR:08:M8V,POS5=AMO:LAS:WVP:03:MTR,POS6=AMO:LAS:DLS:06:MTR,POS7=AMO:LAS:MCN3:07,POS8=AMO:LAS:MCN3:08" )

var xps8Debug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )

set_requestfile_path ( "$(PWD)/../../autosave"  )
set_savefile_path    ( "$(IOC_DATA)/ioc-las-amo-xps3/autosave" )

set_pass0_restoreFile( "ioc-las-amo-xps3.sav"                  )

save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-las-amo-xps3.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

