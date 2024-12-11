#!/reg/g/pcds/package/epics/3.14/ioc/common/NewportXPS8/R2.0.1/bin/linux-x86_64/xps8

epicsEnvSet( "EPICS_NAME", "IOC:LAS:SXR:XPS2" )
epicsEnvSet( "LOCATION",   "SXR:XXX"  )
epicsEnvSet( "IOCSH_PS1",  "ioc-las-sxr-xps2> " )
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

dbLoadRecords( "$(TOP)/db/status_update_arbitrary.db", "DEVICE=SXR:MCN:LAS2,basePeriod='10 second',multiplier=1" )
dbLoadRecords( "$(TOP)/db/XPS8_arbitrary.db",          "DEVICE=SXR:MCN:LAS2,CTRL=mcn-sxr-las2,PORT=5001,POS1=SXR:LAS:MIR:01:M1H,POS2=SXR:LAS:MIR:01:M1V,POS3=SXR:LAS:MIR:02:M2H,POS4=SXR:LAS:MIR:02:M2V,POS5=SXR:LAS:MIR:03:M3H,POS6=SXR:LAS:MIR:03:M3V,POS7=SXR:LAS:MIR:04:M4H,POS8=SXR:LAS:MIR:04:M4V" )

var xps8Debug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )

set_requestfile_path ( "$(PWD)/../../autosave"  )
set_savefile_path    ( "$(IOC_DATA)/ioc-las-sxr-xps2/autosave" )

set_pass0_restoreFile( "ioc-las-sxr-xps2.sav"                  )

save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-las-sxr-xps2.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

