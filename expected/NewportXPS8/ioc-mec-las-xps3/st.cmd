#!/reg/g/pcds/epics/ioc/common/NewportXPS8/R2.0.2/bin/linux-x86_64/xps8

epicsEnvSet( "EPICS_NAME", "IOC:MEC:LAS:XPS3" )
epicsEnvSet( "LOCATION",   "MEC:XXX"  )
epicsEnvSet( "IOCSH_PS1",  "ioc-mec-las-xps3> " )
epicsEnvSet( "ENGINEER",   "Peregrine McGehee (peregrin)"  )


< envPaths

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/xps8.dbd" )
xps8_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocAdmin.db",                "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db",      "IOC=$(EPICS_NAME)" )

dbLoadRecords( "$(TOP)/db/status_update.db",           "DEVICE=MEC:LAS:MMN,C1=17,C8=24,basePeriod='10 second',multiplier=1" )
dbLoadRecords( "$(TOP)/db/XPS8.db",                    "DEVICE=MEC:LAS:MMN,CTRL=mcn-mec-las3,PORT=5001,C1=17,C2=18,C3=19,C4=20,C5=21,C6=22,C7=23,C8=24" )

var xps8Debug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )

set_requestfile_path ( "$(PWD)/../../autosave"  )
set_savefile_path    ( "$(IOC_DATA)/ioc-mec-las-xps3/autosave" )

set_pass0_restoreFile( "ioc-mec-las-xps3.sav"                  )

save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-mec-las-xps3.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

