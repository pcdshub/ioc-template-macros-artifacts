#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/slice

< envPaths

epicsEnvSet( "ENGINEER" , "$$ENGINEER" )
epicsEnvSet( "IOCSH_PS1", "$$IOCNAME>" )
epicsEnvSet( "IOCPVROOT", "$$IOC_PV"   )
epicsEnvSet( "LOCATION",  "$$IF(LOCATION,$$LOCATION,$$IOC_PV)")
epicsEnvSet( "IOC_TOP",   "$$IOCTOP"   )
epicsEnvSet( "TOP",       "$$TOP"      )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOC_TOP)/app/srcProtocol" )

cd( "$(IOC_TOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/slice.dbd")
slice_registerRecordDeviceDriver(pdbbase)

#------------------------------------------------------------------------------
# Asyn support

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1

drvAsynSerialPortConfigure("SLICE0", "/dev/slice-$$SERIAL")
asynSetOption("SLICE$$INDEX", 0, "baud", 9600)
asynSetOption("SLICE$$INDEX", 0, "bits", 8)
asynSetOption("SLICE$$INDEX", 0, "parity", "none")
asynSetOption("SLICE$$INDEX", 0, "stop", 1)

#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
$$IF(DEBUG,,#)asynSetTraceMask( "SLICE0", 0, 0x19) # log everything
#define ASYN_TRACEIO_ASCII  0x0001
#define ASYN_TRACEIO_ESCAPE 0x0002
#define ASYN_TRACEIO_HEX    0x0004
$$IF(DEBUG,,#)asynSetTraceIOMask( "SLICE0", 0, 2)  # Escape the strings.

## Asyn record support
dbLoadRecords( "db/asynRecord.db","P=$$BASE,R=,PORT=SLICE0,ADDR=0,OMAX=0,IMAX=0")

#------------------------------------------------------------------------------
# Load record instances
dbLoadRecords( "db/slice-dhv-ctl.db", "BASE=$$BASE,PORT=SLICE0" )
dbLoadRecords( "db/slice-dhv-chan.db", "BASE=$$BASE,CH=1,PORT=SLICE0" )
dbLoadRecords( "db/slice-dhv-chan.db", "BASE=$$BASE,CH=2,PORT=SLICE0" )



dbLoadRecords( "db/iocSoft.db",			"IOC=$(IOCPVROOT)" )
dbLoadRecords( "db/save_restoreStatus.db",	"P=$(IOCPVROOT):" )

#------------------------------------------------------------------------------
# Setup autosave

set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOCPVROOT):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

# Just restore the settings
set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "$(IOC).sav" )


# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOC).req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
