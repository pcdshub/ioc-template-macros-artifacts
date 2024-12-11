#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/evg

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
dbLoadDatabase("dbd/evg.dbd")
evg_registerRecordDeviceDriver(pdbbase)

# Bump up scanOnce queue size for evr invariant timing
scanOnceSetQueueSize( $$IF(SCAN_ONCE_QUEUE_SIZE,$$SCAN_ONCE_QUEUE_SIZE,4000) )

#------------------------------------------------------------------------------
# Asyn support

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1

$$LOOP(EVG)
drvAsynIPPortConfigure("EVG$$CALC{2*INDEX}", "$$HOST:$$IF(PORT,$$PORT,10200) TCP", 0, 0, 0 )
drvAsynIPPortConfigure("EVG$$CALC{2*INDEX+1}", "$$HOST:$$IF(PORT,$$PORT,10200) TCP", 0, 0, 0 )

#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
$$IF(DEBUG,,#)asynSetTraceMask( "EVG$$CALC{2*INDEX}", 0, 0x9) # log everything
$$IF(DEBUG,,#)asynSetTraceMask( "EVG$$CALC{2*INDEX+1}", 0, 0x9) # log everything
#define ASYN_TRACEIO_ASCII  0x0001
#define ASYN_TRACEIO_ESCAPE 0x0002
#define ASYN_TRACEIO_HEX    0x0004
asynSetTraceIOMask( "EVG$$CALC{2*INDEX}", 0, 2)  # Escape the strings.
asynSetTraceIOMask( "EVG$$CALC{2*INDEX+1}", 0, 2)  # Escape the strings.

## Asyn record support
dbLoadRecords( "db/asynRecord.db","P=$(IOCPVROOT),R=:asyn0,PORT=EVG$$CALC{2*INDEX},ADDR=0,OMAX=0,IMAX=0")
dbLoadRecords( "db/asynRecord.db","P=$(IOCPVROOT),R=:asyn1,PORT=EVG$$CALC{2*INDEX+1},ADDR=0,OMAX=0,IMAX=0")
$$ENDLOOP(EVG)

#------------------------------------------------------------------------------
# Load record instances

$$LOOP(EVG)
dbLoadRecords( "db/evg.db",              	"PREFIX=$$PREFIX,PORT=EVG$$CALC{2*INDEX},PORTX=EVG$$CALC{2*INDEX+1},REBOOT=$(IOCPVROOT):SYSRESET.PROC" )
$$ENDLOOP(EVG)
dbLoadRecords( "db/iocSoft.db",			"IOC=$(IOCPVROOT)" )
dbLoadRecords( "db/save_restoreStatus.db",	"P=$(IOCPVROOT):" )

#------------------------------------------------------------------------------
# Setup autosave

set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOCPVROOT):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

# Just restore the settings
set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "autoSettings.sav" )
set_pass1_restoreFile( "$(IOC).sav" )

# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req", 5, "" )
create_monitor_set( "$(IOC).req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

$$LOOP(EVG)
$$LOOP(8)
dbpf $$PREFIX:ECS:SYS0:$$CALC{INDEX+1}:SEQ.PROC 1
$$ENDLOOP(8)
$$ENDLOOP(EVG)
