#!/cds/group/pcds/epics/ioc/common/agilent5322/R2.0.5/bin/rhel7-x86_64/agilent5322

< envPaths
epicsEnvSet( "ENGINEER",   "Christina Pino (cpino)" )
epicsEnvSet( "EPICS_NAME", "IOC:LAS:CXI:CTR:01")
epicsEnvSet( "LOCATION",   "CXI Laser Locker Frequency Counter" )
epicsEnvSet( "IOCSH_PS1",  "ioc-las-cxi-ctr-01> " )
epicsEnvSet( "BUILD_TOP",  "/reg/g/pcds/epics/ioc/las/agilent5322/R2.0.5/build" )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(TOP)/agilent5322App/srcProtocol" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("$(TOP)/dbd/agilent5322.dbd")
agilent5322_registerRecordDeviceDriver(pdbbase)

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1

# Load record instances
dbLoadRecords( "$(TOP)/db/iocAdmin.db",             "IOC=$(EPICS_NAME),TODFORMAT=%d.%m.%Y %H:%M:%S,FLNK=" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db",   "IOC=$(EPICS_NAME),P=LAS:FS5:CNT:FQ" )
dbLoadRecords( "$(TOP)/db/agilent5322.db",          "DEVICE=LAS:FS5:CNT:FQ,PORT=LAS:FS5:CNT:FQ" )
dbLoadRecords( "$(TOP)/db/asynRecord.db",           "P=LAS:FS5:CNT:FQ,R=:AsynIO,PORT=LAS:FS5:CNT:FQ,ADDR=0,IMAX=0,OMAX=0" )

# Configure each device
# LCLS used port 5024, but Agilent User's Guide says 5025
drvAsynIPPortConfigure( "LAS:FS5:CNT:FQ", "counter-las-cxi-01.pcdsn:5025 TCP", 0, 0, 0 )


# Optional: Enable tracing
#asynSetTraceIOMask( "LAS:FS5:CNT:FQ",	0,		2 )
#asynSetTraceMask(   "LAS:FS5:CNT:FQ",	0,		9 )

# Send trace output to motor specific log files
# asynSetTraceFile(   "LAS:FS5:CNT:FQ",	0, "$(IOC_DATA)/ioc-las-cxi-ctr-01/logs/LAS:FS5:CNT:FQ.log" )

# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(BUILD_TOP)/autosave" )

# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )

save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

# Just restore the settings
set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "$(IOC).sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "ioc-las-cxi-ctr-01.req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
