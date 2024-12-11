#!/reg/g/pcds/epics/ioc/common/arcus/R4.2.0/bin/linux-x86_64/arcus

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:CXI:USR:PMC100" )
epicsEnvSet( "LOCATION",             "CXI:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-cxi-usr-pmc100> " )
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

epicsEnvSet("ASYNPORT", "CXI:USR:MZM:01")
drvAsynSerialPortConfigure("$(ASYNPORT)","/dev/arcusEX01",0,0,0)
asynSetTraceIOMask( "$(ASYNPORT)", 0, 1)
asynSetTraceMask( "$(ASYNPORT)", 0, 1) 
dbLoadRecords( "$(TOP)/db/arcus.db", "MOTOR=CXI:USR:MZM:01,ASYN=$(ASYNPORT)" )
epicsEnvSet("ASYNPORT", "CXI:USR:MZM:02")
drvAsynSerialPortConfigure("$(ASYNPORT)","/dev/arcusEX02",0,0,0)
asynSetTraceIOMask( "$(ASYNPORT)", 0, 1)
asynSetTraceMask( "$(ASYNPORT)", 0, 1) 
dbLoadRecords( "$(TOP)/db/arcus.db", "MOTOR=CXI:USR:MZM:02,ASYN=$(ASYNPORT)" )
epicsEnvSet("ASYNPORT", "CXI:USR:MZM:03")
drvAsynSerialPortConfigure("$(ASYNPORT)","/dev/arcusEX03",0,0,0)
asynSetTraceIOMask( "$(ASYNPORT)", 0, 1)
asynSetTraceMask( "$(ASYNPORT)", 0, 1) 
dbLoadRecords( "$(TOP)/db/arcus.db", "MOTOR=CXI:USR:MZM:03,ASYN=$(ASYNPORT)" )
epicsEnvSet("ASYNPORT", "CXI:USR:MZM:04")
drvAsynSerialPortConfigure("$(ASYNPORT)","/dev/arcusEX13",0,0,0)
asynSetTraceIOMask( "$(ASYNPORT)", 0, 1)
asynSetTraceMask( "$(ASYNPORT)", 0, 1) 
dbLoadRecords( "$(TOP)/db/arcus.db", "MOTOR=CXI:USR:MZM:04,ASYN=$(ASYNPORT)" )
epicsEnvSet("ASYNPORT", "CXI:USR:MZM:05")
drvAsynSerialPortConfigure("$(ASYNPORT)","/dev/arcusEX40",0,0,0)
asynSetTraceIOMask( "$(ASYNPORT)", 0, 1)
asynSetTraceMask( "$(ASYNPORT)", 0, 1) 
dbLoadRecords( "$(TOP)/db/arcus.db", "MOTOR=CXI:USR:MZM:05,ASYN=$(ASYNPORT)" )
epicsEnvSet("ASYNPORT", "CXI:USR:MZM:06")
drvAsynSerialPortConfigure("$(ASYNPORT)","/dev/arcusEX41",0,0,0)
asynSetTraceIOMask( "$(ASYNPORT)", 0, 1)
asynSetTraceMask( "$(ASYNPORT)", 0, 1) 
dbLoadRecords( "$(TOP)/db/arcus.db", "MOTOR=CXI:USR:MZM:06,ASYN=$(ASYNPORT)" )

var arcusRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-cxi-usr-pmc100/autosave" )

set_pass0_restoreFile( "ioc-cxi-usr-pmc100.sav"                  )


# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-cxi-usr-pmc100.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

