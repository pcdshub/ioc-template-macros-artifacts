#!/reg/g/pcds/package/epics/3.14/ioc/common/HPLS200/R1.0.0/bin/linux-x86_64/HPLS200

< envPaths
epicsEnvSet( "ENGINEER",  "Karl Gumerlock (klg)" )
epicsEnvSet( "EPICS_NAME","IOC:MEC:HPLS200:01")
epicsEnvSet( "LOCATION",  "MEC:EXP:OPAL" )
epicsEnvSet( "IOCSH_PS1", "ioc-mec-hpls200-01> " )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(TOP)/HPLS200App/srcProtocol" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("$(TOP)/dbd/HPLS200.dbd")
HPLS200_registerRecordDeviceDriver(pdbbase)

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1

# Configure each device
epicsEnvSet( "DEV1", "MEC:EXP:HPL:01" )
drvAsynSerialPortConfigure( "$(DEV1)", "/dev/ftdi-TLY2GTSS", 0, 0, 0 )
asynSetOption( "$(DEV1)", 0, "baud", "115200" )
asynSetOption( "$(DEV1)", 0, "bits", "8" )
asynSetOption( "$(DEV1)", 0, "parity", "none" )
asynSetOption( "$(DEV1)", 0, "stop", "1" )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocAdmin.db",			"IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db",	"IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/HPLS200.db",		"P=$(DEV1)" )


# Optional: Enable tracing
#asynSetTraceIOMask( "$(DEV1)",	0,		2 )
#asynSetTraceMask(   "$(DEV1)",	0,		9 )

# Send trace output to motor specific log files
#asynSetTraceFile(   "$(DEV1)",	0, "$(IOC_DATA)/ioc-mec-hpls200-01/logs/$(DEV1).log" )

# Setup autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_savefile_path( "$(IOC_DATA)/ioc-mec-hpls200-01/autosave" )
set_requestfile_path( "$(TOP)/autosave" )

# Just restore the settings
set_pass0_restoreFile( "ioc-mec-hpls200-01.sav" )
set_pass1_restoreFile( "ioc-mec-hpls200-01.sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "ioc-mec-hpls200-01.req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
