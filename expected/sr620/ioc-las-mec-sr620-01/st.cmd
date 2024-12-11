#!/cds/group/pcds/epics/ioc/common/sr620/R0.9.3/bin/rhel7-x86_64/sr620

< envPaths
epicsEnvSet( "ENGINEER",   "Karl Gumerlock (klg)" )
epicsEnvSet( "EPICS_NAME", "IOC:LAS:MEC:SR620:01")
epicsEnvSet( "LOCATION",   "LAS:FS6:IOC:CNT:TI" )
epicsEnvSet( "IOCSH_PS1",  "ioc-las-mec-sr620-01> " )
epicsEnvSet( "BUILD_TOP",  "/reg/g/pcds/epics/ioc/las/sr620/R1.1.6/build" )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(TOP)/sr620App/srcProtocol" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("$(TOP)/dbd/sr620.dbd")
sr620_registerRecordDeviceDriver(pdbbase)

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",			"IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db",	"IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/sr620.db",	         	"P=LAS:FS6:CNT:TI" )
dbLoadRecords( "$(TOP)/db/asynRecord.db",	        "P=LAS:FS6:CNT:TI,PORT=LAS:FS6:CNT:TI,R=,ADDR=0,IMAX=100,OMAX=100" )

# Open serial communication with device
drvAsynIPPortConfigure( "LAS:FS6:CNT:TI", "moxa-fs6-01:4016 TCP", 0, 0, 0 )


# Optional: Enable tracing
#asynSetTraceIOMask( "LAS:FS6:CNT:TI",	0,		2 )
#asynSetTraceMask(   "LAS:FS6:CNT:TI)",	0,		9 )

# Send trace output to motor specific log files
# asynSetTraceFile(   "LAS:FS6:CNT:TI",	0, "$(IOC_DATA)/ioc-las-mec-sr620-01/logs/LAS:FS6:CNT:TI.log" )

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
create_monitor_set( "ioc-las-mec-sr620-01.req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
