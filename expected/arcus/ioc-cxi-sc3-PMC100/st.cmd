#!/reg/g/pcds/epics/ioc/common/arcus/R4.2.0/bin/linux-x86_64/arcus

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:CXI:SC3:PMC100" )
epicsEnvSet( "LOCATION",             "CXI:SC3"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-cxi-sc3-PMC100> " )
epicsEnvSet( "ENGINEER",             "Evan Rodriguez (erod)"  )
epicsEnvSet("STREAM_PROTOCOL_PATH",  "$(TOP)/arcusApp/protocols")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/arcus.dbd" )
arcus_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )

epicsEnvSet("ASYNPORT", "CXI:SC3:MZM:01")
drvAsynSerialPortConfigure("$(ASYNPORT)","/dev/arcusEX31",0,0,0)
asynSetTraceIOMask( "$(ASYNPORT)", 0, 1)
asynSetTraceMask( "$(ASYNPORT)", 0, 1) 
dbLoadRecords( "$(TOP)/db/arcus.db", "MOTOR=CXI:SC3:MZM:01,ASYN=$(ASYNPORT)" )
epicsEnvSet("ASYNPORT", "CXI:SC3:MZM:02")
drvAsynSerialPortConfigure("$(ASYNPORT)","/dev/arcusEX36",0,0,0)
asynSetTraceIOMask( "$(ASYNPORT)", 0, 1)
asynSetTraceMask( "$(ASYNPORT)", 0, 1) 
dbLoadRecords( "$(TOP)/db/arcus.db", "MOTOR=CXI:SC3:MZM:02,ASYN=$(ASYNPORT)" )
epicsEnvSet("ASYNPORT", "CXI:SC3:MZM:03")
drvAsynSerialPortConfigure("$(ASYNPORT)","/dev/arcusEX02",0,0,0)
asynSetTraceIOMask( "$(ASYNPORT)", 0, 1)
asynSetTraceMask( "$(ASYNPORT)", 0, 1) 
dbLoadRecords( "$(TOP)/db/arcus.db", "MOTOR=CXI:SC3:MZM:03,ASYN=$(ASYNPORT)" )
epicsEnvSet("ASYNPORT", "CXI:SC3:MZM:04")
drvAsynSerialPortConfigure("$(ASYNPORT)","/dev/arcusEX38",0,0,0)
asynSetTraceIOMask( "$(ASYNPORT)", 0, 1)
asynSetTraceMask( "$(ASYNPORT)", 0, 1) 
dbLoadRecords( "$(TOP)/db/arcus.db", "MOTOR=CXI:SC3:MZM:04,ASYN=$(ASYNPORT)" )

var arcusRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-cxi-sc3-PMC100/autosave" )

set_pass0_restoreFile( "ioc-cxi-sc3-PMC100.sav"                  )


# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-cxi-sc3-PMC100.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

