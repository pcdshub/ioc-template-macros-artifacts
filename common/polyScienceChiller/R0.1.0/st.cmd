#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/polyScienceChiller


< envPaths

epicsEnvSet( "ENGINEER" , "$$ENGINEER" )
epicsEnvSet( "IOCSH_PS1", "$$IOCNAME>" )
epicsEnvSet( "IOCENAME", "$$TRANSLATE(IOCNAME,"a-z_-","A-Z::")" )
epicsEnvSet( "IOCPVROOT", "$$IF(IOCPVROOT,$$IOCPVROOT,$(IOCENAME)")
epicsEnvSet( "LOCATION",  "$$IF(LOCATION,$$LOCATION,$$IOCPVROOT)")
epicsEnvSet( "IP",        "$$IP"       )
epicsEnvSet( "IP_PORT",	  "$$IP_PORT"     )
epicsEnvSet( "BASE_NAME", "$$NAME"     )
epicsEnvSet( "IOC_TOP",    "$$IOCTOP"   )
epicsEnvSet( "TOP",       "$$TOP"      )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOC_TOP)/polyScienceChillerApp/srcProtocol" )

cd( "$(IOC_TOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/polyScienceChiller.dbd")
polyScienceChiller_registerRecordDeviceDriver(pdbbase)

#------------------------------------------------------------------------------
# Asyn support

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1

# Initialize IP Asyn support, configure logging before enabling autoconnect
drvAsynIPPortConfigure("$(BASE_NAME)","$(IP):$(IP_PORT)", 0, 0, 0)
asynSetTraceFile( "$(BASE_NAME)", 0, "$(IOC_DATA)$(IOC)/iocInfo/asyn.log" )

#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
asynSetTraceMask( "$(BASE_NAME)", 0, 0xff) # log everything
#asynSetTraceIOMask( "$(BASE_NAME)", 0, 4)

## Asyn record support
dbLoadRecords( "db/asynRecord.db","P=$(BASE_NAME),R=,PORT=$(BASE_NAME),ADDR=0,OMAX=0,IMAX=0")

asynAutoConnect("$(BASE_NAME)", 0, 1)
epicsThreadSleep(0.01) # give autoconnect time, or other asyn commands fail.

# Disable error messages from asyn.
asynSetTraceMask("$(BASE_NAME)", 0, 0x0)

#------------------------------------------------------------------------------
# Load record instances

dbLoadRecords( "db/psChiller.db",           	"P=$(BASE_NAME)" )
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
