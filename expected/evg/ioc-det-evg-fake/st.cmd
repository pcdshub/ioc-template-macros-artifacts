#!/reg/g/pcds/epics/ioc/common/evg/R1.0.5/bin/linux-x86/evg

< envPaths

epicsEnvSet( "ENGINEER" , "Daniel Damiani (ddamiani)" )
epicsEnvSet( "IOCSH_PS1", "ioc-det-evg-fake>" )
epicsEnvSet( "IOCPVROOT", "IOC:DET:EVG:0"   )
epicsEnvSet( "LOCATION",  "ASC Detector Lab (B057 RM1040)")
epicsEnvSet( "IOC_TOP",   "/reg/g/pcds/epics/ioc/common/evg/R1.0.5"   )
epicsEnvSet( "TOP",       "/reg/g/pcds/epics/ioc/common/evg/R1.0.5/children/build"      )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOC_TOP)/app/srcProtocol" )

cd( "$(IOC_TOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/evg.dbd")
evg_registerRecordDeviceDriver(pdbbase)

# Bump up scanOnce queue size for evr invariant timing
scanOnceSetQueueSize( 4000 )

#------------------------------------------------------------------------------
# Asyn support

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1

drvAsynIPPortConfigure("EVG0", "ioc-det-evg:10200 TCP", 0, 0, 0 )
drvAsynIPPortConfigure("EVG1", "ioc-det-evg:10200 TCP", 0, 0, 0 )

#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
#asynSetTraceMask( "EVG0", 0, 0x9) # log everything
#asynSetTraceMask( "EVG1", 0, 0x9) # log everything
#define ASYN_TRACEIO_ASCII  0x0001
#define ASYN_TRACEIO_ESCAPE 0x0002
#define ASYN_TRACEIO_HEX    0x0004
asynSetTraceIOMask( "EVG0", 0, 2)  # Escape the strings.
asynSetTraceIOMask( "EVG1", 0, 2)  # Escape the strings.

## Asyn record support
dbLoadRecords( "db/asynRecord.db","P=$(IOCPVROOT),R=:asyn0,PORT=EVG0,ADDR=0,OMAX=0,IMAX=0")
dbLoadRecords( "db/asynRecord.db","P=$(IOCPVROOT),R=:asyn1,PORT=EVG1,ADDR=0,OMAX=0,IMAX=0")

#------------------------------------------------------------------------------
# Load record instances

dbLoadRecords( "db/evg.db",              	"PREFIX=DET,PORT=EVG0,PORTX=EVG1,REBOOT=$(IOCPVROOT):SYSRESET.PROC" )
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

dbpf DET:ECS:SYS0:1:SEQ.PROC 1
dbpf DET:ECS:SYS0:2:SEQ.PROC 1
dbpf DET:ECS:SYS0:3:SEQ.PROC 1
dbpf DET:ECS:SYS0:4:SEQ.PROC 1
dbpf DET:ECS:SYS0:5:SEQ.PROC 1
dbpf DET:ECS:SYS0:6:SEQ.PROC 1
dbpf DET:ECS:SYS0:7:SEQ.PROC 1
dbpf DET:ECS:SYS0:8:SEQ.PROC 1
