#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86)/sr620

< envPaths
epicsEnvSet( "ENGINEER",   "$$ENGINEER" )
epicsEnvSet( "EPICS_NAME", "$$TRANSLATE(IOCNAME,"a-z_-","A-Z::")")
epicsEnvSet( "LOCATION",   "$$LOCATION" )
epicsEnvSet( "IOCSH_PS1",  "$$IOCNAME> " )
epicsEnvSet( "BUILD_TOP",  "$$TOP" )
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
dbLoadRecords( "$(TOP)/db/sr620.db",	         	"P=$$DEVICE" )
dbLoadRecords( "$(TOP)/db/asynRecord.db",	        "P=$$DEVICE,PORT=$$DEVICE,R=,ADDR=0,IMAX=100,OMAX=100" )

# Open serial communication with device
drvAsynIPPortConfigure( "$$DEVICE", "$$PORT TCP", 0, 0, 0 )


# Optional: Enable tracing
#asynSetTraceIOMask( "$$DEVICE",	0,		2 )
#asynSetTraceMask(   "$$DEVICE)",	0,		9 )

# Send trace output to motor specific log files
# asynSetTraceFile(   "$$DEVICE",	0, "$(IOC_DATA)/$$IOCNAME/logs/$$DEVICE.log" )

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
create_monitor_set( "$$IOCNAME.req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
