#!/reg/g/pcds/package/epics/3.14/ioc/common/NewportXPS8/R2.0.1/bin/linux-x86_64/xps8

epicsEnvSet( "EPICS_NAME", "IOC:LAS:SXR:XPS1" )
epicsEnvSet( "LOCATION",   "SXR:XXX"  )
epicsEnvSet( "IOCSH_PS1",  "ioc-las-sxr-xps1> " )
epicsEnvSet( "ENGINEER",   "Ankush Mitra (mitra)"  )


< envPaths

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/xps8.dbd" )
xps8_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocAdmin.db",                "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db",      "IOC=$(EPICS_NAME)" )

dbLoadRecords( "$(TOP)/db/status_update_arbitrary.db", "DEVICE=SXR:MCN:LAS1,basePeriod='10 second',multiplier=1" )
dbLoadRecords( "$(TOP)/db/XPS8_arbitrary.db",          "DEVICE=SXR:MCN:LAS1,CTRL=mcn-sxr-las1,PORT=5001,POS1=SXR:LAS:XPS:01:MTR,POS2=SXR:LAS:MCN1:02,POS3=SXR:LAS:MCN1:03,POS4=SXR:LAS:WVP:01:MTR,POS5=SXR:LAS:WVP:02:MTR,POS6=SXR:LAS:MCN1:06,POS7=SXR:LAS:DLS:01:MTR,POS8=SXR:LAS:MCN1:08" )

var xps8Debug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )

set_requestfile_path ( "$(PWD)/../../autosave"  )
set_savefile_path    ( "$(IOC_DATA)/ioc-las-sxr-xps1/autosave" )

set_pass0_restoreFile( "ioc-las-sxr-xps1.sav"                  )

save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-las-sxr-xps1.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

