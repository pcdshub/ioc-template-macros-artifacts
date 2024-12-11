#!$$IOCTOP/bin/linux-x86_64/xps8

epicsEnvSet( "EPICS_NAME", "$$TRANSLATE(IOCNAME,"a-z_-","A-Z::")" )
epicsEnvSet( "LOCATION",   "$$LOCATION"  )
epicsEnvSet( "IOCSH_PS1",  "$$IOCNAME> " )
epicsEnvSet( "ENGINEER",   "$$ENGINEER"  )


< envPaths

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/xps8.dbd" )
xps8_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocAdmin.db",                "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db",      "IOC=$(EPICS_NAME)" )

$$IF(POS1)
dbLoadRecords( "$(TOP)/db/status_update_arbitrary.db", "DEVICE=$$DEVICE,basePeriod='10 second',multiplier=1" )
dbLoadRecords( "$(TOP)/db/XPS8_arbitrary.db",          "DEVICE=$$DEVICE,CTRL=$$CTRL_NAME,PORT=5001,POS1=$$POS1,POS2=$$POS2,POS3=$$POS3,POS4=$$POS4,POS5=$$POS5,POS6=$$POS6,POS7=$$POS7,POS8=$$POS8" )
$$ELSE(POS1)
dbLoadRecords( "$(TOP)/db/status_update.db",           "DEVICE=$$DEVICE,C1=$$C1,C8=$$C8,basePeriod='10 second',multiplier=1" )
dbLoadRecords( "$(TOP)/db/XPS8.db",                    "DEVICE=$$DEVICE,CTRL=$$CTRL_NAME,PORT=5001,C1=$$C1,C2=$$C2,C3=$$C3,C4=$$C4,C5=$$C5,C6=$$C6,C7=$$C7,C8=$$C8" )
$$ENDIF(POS1)

var xps8Debug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )

set_requestfile_path ( "$(PWD)/../../autosave"  )
set_savefile_path    ( "$(IOC_DATA)/$$IOCNAME/autosave" )

set_pass0_restoreFile( "$$IOCNAME.sav"                  )

save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "$$IOCNAME.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

