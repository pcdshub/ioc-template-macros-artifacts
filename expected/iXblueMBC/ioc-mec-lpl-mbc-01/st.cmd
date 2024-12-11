#!/reg/g/pcds/epics/ioc/common/iXblueMBC/R0.1.0/bin/linux-x86_64/iXblueMBC


< envPaths

epicsEnvSet( "ENGINEER" , "TDB" )
epicsEnvSet( "IOCSH_PS1", "ioc-mec-lpl-mbc-01>" )
epicsEnvSet( "IOCENAME", "IOC:MEC:LPL:MBC:01" )
epicsEnvSet( "IOCPVROOT", "MEC:LPL:MBC:IOC:01")
epicsEnvSet( "LOCATION",  "MEC:LPL:MBC:IOC:01")
epicsEnvSet( "TTY_PORT",  "/dev/ttyUSB0"       )
epicsEnvSet( "BASE_NAME", "MEC:LPL:MBC:01"     )
epicsEnvSet( "IOC_TOP",    "/reg/g/pcds/epics/ioc/common/iXblueMBC/R0.1.0"   )
epicsEnvSet( "TOP",       "/reg/g/pcds/epics/ioc/mec/iXblueMBC/R0.1.0/build"      )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOC_TOP)/iXblueMBCApp/srcProtocol" )

cd( "$(IOC_TOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/iXblueMBC.dbd")
iXblueMBC_registerRecordDeviceDriver(pdbbase)

#------------------------------------------------------------------------------
# Asyn support

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1

# Initialize Serial Asyn support, configure logging before enabling autoconnect
drvAsynSerialPortConfigure( "$(BASE_NAME)", "$(TTY_PORT)", 0, 0, 0 )
asynSetTraceFile( "$(BASE_NAME)", 0, "$(IOC_DATA)$(IOC)/iocInfo/asyn.log" )

#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
asynSetTraceMask( "$(BASE_NAME)", 0, 0xff) # log everything
#asynSetTraceIOMask( "$(BASE_NAME)", 0, 2)

asynSetOption("$(BASE_NAME)", -1, "baud",    "115200")
asynSetOption("$(BASE_NAME)", -1, "bits",    "8")
asynSetOption("$(BASE_NAME)", -1, "parity",  "none")
asynSetOption("$(BASE_NAME)", -1, "stop",    "1")
asynSetOption("$(BASE_NAME)", -1, "clocal",  "N")
asynSetOption("$(BASE_NAME)", -1, "crtscts", "N")

## Asyn record support
dbLoadRecords( "db/asynRecord.db","P=$(BASE_NAME),R=,PORT=$(BASE_NAME),ADDR=0,OMAX=0,IMAX=0")

asynAutoConnect("$(BASE_NAME)", 0, 1)
epicsThreadSleep(0.01) # give autoconnect time, or other asyn commands fail.

# Disable error messages from asyn.
asynSetTraceMask("$(BASE_NAME)", 0, 0x0)

#------------------------------------------------------------------------------
# Load record instances

dbLoadRecords( "db/iXblueMBC.db",              	"P=$(BASE_NAME), PORT=$(BASE_NAME)" )
dbLoadRecords( "db/iocAdmin.db",		"IOC=$(IOCENAME)" )
dbLoadRecords( "db/save_restoreStatus.db",	"IOC=$(IOCPVROOT)" )

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
