#!/reg/g/pcds/epics/ioc/common/NewportXPS8/R2.0.2/bin/rhel7-x86_64/xps8

epicsEnvSet( "EPICS_NAME", "IOC:MFX:XPS:LBL" )
epicsEnvSet( "LOCATION",   "SLAC:LCLS"  )
epicsEnvSet( "IOCSH_PS1",  "ioc-mfx-xps-lbl> " )
epicsEnvSet( "ENGINEER",   "Alex Batyuk (batyuk)"  )


< envPaths

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/xps8.dbd" )
xps8_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocAdmin.db",                "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db",      "IOC=$(EPICS_NAME)" )

dbLoadRecords( "$(TOP)/db/status_update.db",           "DEVICE=MFX:USR:MMN,C1=41,C8=48,basePeriod='10 second',multiplier=1" )
dbLoadRecords( "$(TOP)/db/XPS8.db",                    "DEVICE=MFX:USR:MMN,CTRL=mcn-lbl-01,PORT=5001,C1=41,C2=42,C3=43,C4=44,C5=45,C6=46,C7=47,C8=48" )

var xps8Debug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )

set_requestfile_path ( "$(PWD)/../../autosave"  )
set_savefile_path    ( "$(IOC_DATA)/ioc-mfx-xps-lbl/autosave" )

set_pass0_restoreFile( "ioc-mfx-xps-lbl.sav"                  )

save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-mfx-xps-lbl.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

