#!/reg/g/pcds/epics/ioc/common/arcus/R4.1.0/bin/rhel7-x86_64/arcus

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:CXI:SC1:PMC100" )
epicsEnvSet( "LOCATION",             "CXI:SC1"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-cxi-sc1-PMC100> " )
epicsEnvSet( "ENGINEER",             "Kaushik Malapati (kaushikm)"  )
epicsEnvSet("STREAM_PROTOCOL_PATH",  "$(TOP)/arcusApp/protocols")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/arcus.dbd" )
arcus_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )

epicsEnvSet("ASYNPORT", "CXI:SC1:MZM:01")
drvAsynSerialPortConfigure("$(ASYNPORT)","/dev/arcusEX01",0,0,0)
asynSetTraceIOMask( "$(ASYNPORT)", 0, 1)
asynSetTraceMask( "$(ASYNPORT)", 0, 1) 
dbLoadRecords( "$(TOP)/db/arcus.db", "MOTOR=CXI:SC1:MZM:01,ASYN=$(ASYNPORT)" )
epicsEnvSet("ASYNPORT", "CXI:SC1:MZM:04")
drvAsynSerialPortConfigure("$(ASYNPORT)","/dev/arcusEX14",0,0,0)
asynSetTraceIOMask( "$(ASYNPORT)", 0, 1)
asynSetTraceMask( "$(ASYNPORT)", 0, 1) 
dbLoadRecords( "$(TOP)/db/arcus.db", "MOTOR=CXI:SC1:MZM:04,ASYN=$(ASYNPORT)" )
epicsEnvSet("ASYNPORT", "CXI:SC1:MZM:05")
drvAsynSerialPortConfigure("$(ASYNPORT)","/dev/arcusEX11",0,0,0)
asynSetTraceIOMask( "$(ASYNPORT)", 0, 1)
asynSetTraceMask( "$(ASYNPORT)", 0, 1) 
dbLoadRecords( "$(TOP)/db/arcus.db", "MOTOR=CXI:SC1:MZM:05,ASYN=$(ASYNPORT)" )
epicsEnvSet("ASYNPORT", "CXI:SC1:MZM:14")
drvAsynSerialPortConfigure("$(ASYNPORT)","/dev/arcusEX13",0,0,0)
asynSetTraceIOMask( "$(ASYNPORT)", 0, 1)
asynSetTraceMask( "$(ASYNPORT)", 0, 1) 
dbLoadRecords( "$(TOP)/db/arcus.db", "MOTOR=CXI:SC1:MZM:14,ASYN=$(ASYNPORT)" )

var arcusRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-cxi-sc1-PMC100/autosave" )

set_pass0_restoreFile( "ioc-cxi-sc1-PMC100.sav"                  )


# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-cxi-sc1-PMC100.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

