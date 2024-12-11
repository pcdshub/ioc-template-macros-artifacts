#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,rhel7-x86_64)/arcus

< envPaths

epicsEnvSet( "EPICS_NAME",           "$$TRANSLATE(IOCNAME,"a-z_-","A-Z::")" )
epicsEnvSet( "LOCATION",             "$$LOCATION"  )
epicsEnvSet( "IOCSH_PS1",            "$$IOCNAME> " )
epicsEnvSet( "ENGINEER",             "$$ENGINEER"  )
epicsEnvSet("STREAM_PROTOCOL_PATH",  "$(TOP)/arcusApp/protocols")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/arcus.dbd" )
arcus_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )

$$LOOP(PMC100)
epicsEnvSet("ASYNPORT", "$$IF(ASYN,$$ASYN,$$NAME)")
drvAsynSerialPortConfigure("$(ASYNPORT)","$$USB",0,0,0)
asynSetTraceIOMask( "$(ASYNPORT)", 0, 1)
asynSetTraceMask( "$(ASYNPORT)", 0, $$IF(DEBUG,9,1)) 
dbLoadRecords( "$(TOP)/db/arcus.db", "MOTOR=$$NAME,ASYN=$(ASYNPORT)" )
$$ENDLOOP(PMC100)

var arcusRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/$$IOCNAME/autosave" )

set_pass0_restoreFile( "$$IOCNAME.sav"                  )


# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "$$IOCNAME.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

