#!$$IOCTOP/bin/$$ARCH/HPLS200

< envPaths
epicsEnvSet( "ENGINEER",  "$$ENGINEER" )
epicsEnvSet( "EPICS_NAME","$$TRANSLATE(IOCNAME,"a-z_-","A-Z::")")
epicsEnvSet( "LOCATION",  "$$LOCATION" )
epicsEnvSet( "IOCSH_PS1", "$$IOCNAME> " )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(TOP)/HPLS200App/srcProtocol" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("$(TOP)/dbd/HPLS200.dbd")
HPLS200_registerRecordDeviceDriver(pdbbase)

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1

# Configure each device
epicsEnvSet( "DEV1", "$$DEVICE" )
drvAsynSerialPortConfigure( "$(DEV1)", "$$PORT", 0, 0, 0 )
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
#asynSetTraceFile(   "$(DEV1)",	0, "$(IOC_DATA)/$$IOCNAME/logs/$(DEV1).log" )

# Setup autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_savefile_path( "$(IOC_DATA)/$$IOCNAME/autosave" )
set_requestfile_path( "$(TOP)/autosave" )

# Just restore the settings
set_pass0_restoreFile( "$$IOCNAME.sav" )
set_pass1_restoreFile( "$$IOCNAME.sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$$IOCNAME.req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
