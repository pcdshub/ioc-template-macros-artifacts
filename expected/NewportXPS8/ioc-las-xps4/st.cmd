#!/reg/g/pcds/package/epics/3.14/ioc/common/NewportXPS8/R2.0.1/bin/linux-x86_64/xps8

epicsEnvSet( "EPICS_NAME", "IOC:LAS:XPS4" )
epicsEnvSet( "LOCATION",   "LAS:NEH:RXX"  )
epicsEnvSet( "IOCSH_PS1",  "ioc-las-xps4> " )
epicsEnvSet( "ENGINEER",   "Karl Gumerlock (klg)"  )


< envPaths

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/xps8.dbd" )
xps8_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocAdmin.db",                "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db",      "IOC=$(EPICS_NAME)" )

dbLoadRecords( "$(TOP)/db/status_update_arbitrary.db", "DEVICE=LAS:NEH:MCN4,basePeriod='10 second',multiplier=1" )
dbLoadRecords( "$(TOP)/db/XPS8_arbitrary.db",          "DEVICE=LAS:NEH:MCN4,CTRL=mcn-las-xps4,PORT=5001,POS1=LAS:NEH:MMN:01,POS2=LAS:NEH:MMN:02,POS3=LAS:NEH:MMN:03,POS4=LAS:NEH:MMN:04,POS5=LAS:FS1:MMN:FQ,POS6=LAS:FS2:MMN:FQ,POS7=LAS:FS3:MMN:FQ,POS8=LAS:NEH:MMN:08" )

var xps8Debug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )

set_requestfile_path ( "$(PWD)/../../autosave"  )
set_savefile_path    ( "$(IOC_DATA)/ioc-las-xps4/autosave" )

set_pass0_restoreFile( "ioc-las-xps4.sav"                  )

save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-las-xps4.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

