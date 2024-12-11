#!/reg/g/pcds/epics/ioc/common/NewportXPS8/R2.0.2/bin/rhel7-x86_64/xps8

epicsEnvSet( "EPICS_NAME", "IOC:XPP:USER:XPS1" )
epicsEnvSet( "LOCATION",   "SLAC:LCLS"  )
epicsEnvSet( "IOCSH_PS1",  "ioc-xpp-user-xps1> " )
epicsEnvSet( "ENGINEER",   "Aalayah Spencer (spencera)"  )


< envPaths

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/xps8.dbd" )
xps8_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocAdmin.db",                "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db",      "IOC=$(EPICS_NAME)" )

dbLoadRecords( "$(TOP)/db/status_update.db",           "DEVICE=XPP:USR:MMN,C1=01,C8=08,basePeriod='10 second',multiplier=1" )
dbLoadRecords( "$(TOP)/db/XPS8.db",                    "DEVICE=XPP:USR:MMN,CTRL=mcn-xpp-user1,PORT=5001,C1=01,C2=02,C3=03,C4=04,C5=05,C6=06,C7=07,C8=08" )

var xps8Debug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )

set_requestfile_path ( "$(PWD)/../../autosave"  )
set_savefile_path    ( "$(IOC_DATA)/ioc-xpp-user-xps1/autosave" )

set_pass0_restoreFile( "ioc-xpp-user-xps1.sav"                  )

save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xpp-user-xps1.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
