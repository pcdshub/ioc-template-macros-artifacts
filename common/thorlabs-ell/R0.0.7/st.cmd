#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/ell

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
dbLoadDatabase("dbd/ell.dbd")
ell_registerRecordDeviceDriver(pdbbase)

#------------------------------------------------------------------------------
# Asyn support

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1

$$LOOP(PORT)
drvAsynSerialPortConfigure(ELL$$INDEX, "/dev/ftdi-$$SERIAL")

#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
$$IF(DEBUG,,#)asynSetTraceMask( "ELL$$INDEX", 0, 0x19) # log everything
#define ASYN_TRACEIO_ASCII  0x0001
#define ASYN_TRACEIO_ESCAPE 0x0002
#define ASYN_TRACEIO_HEX    0x0004
$$IF(DEBUG,,#)asynSetTraceIOMask( "ELL$$INDEX", 0, 2)  # Escape the strings.

## Asyn record support
dbLoadRecords( "db/asynRecord.db","P=$$BASE,R=,PORT=ELL$$INDEX,ADDR=0,OMAX=0,IMAX=0")
$$ENDLOOP(PORT)

#------------------------------------------------------------------------------
# Load record instances
$$LOOP(ELL6)
dbLoadRecords( "db/ellALL.db", "BASE=$$PORTBASE:M$$ADDRESS,ADDRESS=$$ADDRESS,PORT=ELL$$PORTINDEX" )
dbLoadRecords( "db/ell6.db", "BASE=$$PORTBASE:M$$ADDRESS,ADDRESS=$$ADDRESS,PORT=ELL$$PORTINDEX" )
$$ENDLOOP(ELL6)

$$LOOP(ELL9)
dbLoadRecords( "db/ellALL.db", "BASE=$$PORTBASE:M$$ADDRESS,ADDRESS=$$ADDRESS,PORT=ELL$$PORTINDEX" )
dbLoadRecords( "db/ell9.db", "BASE=$$PORTBASE:M$$ADDRESS,ADDRESS=$$ADDRESS,PORT=ELL$$PORTINDEX" )
dbLoadRecords( "db/ellJogHome.db", "BASE=$$PORTBASE:M$$ADDRESS,ADDRESS=$$ADDRESS,PORT=ELL$$PORTINDEX" )
$$ENDLOOP(ELL9)

$$LOOP(ELL14)
dbLoadRecords( "db/ellALL.db", "BASE=$$PORTBASE:M$$ADDRESS,ADDRESS=$$ADDRESS,PORT=ELL$$PORTINDEX,HOPR=360,EGU=deg,SCALE=398.222222222" )
dbLoadRecords( "db/ellJogHome.db", "BASE=$$PORTBASE:M$$ADDRESS,ADDRESS=$$ADDRESS,PORT=ELL$$PORTINDEX,HOPR=360,EGU=deg,SCALE=398.222222222" )
dbLoadRecords( "db/ellMoveOptimize.db", "BASE=$$PORTBASE:M$$ADDRESS,ADDRESS=$$ADDRESS,PORT=ELL$$PORTINDEX,HOPR=360,EGU=deg,SCALE=398.222222222" )
$$ENDLOOP(ELL14)

$$LOOP(ELL20)
dbLoadRecords( "db/ellALL.db", "BASE=$$PORTBASE:M$$ADDRESS,ADDRESS=$$ADDRESS,PORT=ELL$$PORTINDEX,HOPR=60,EGU=mm,SCALE=1024" )
dbLoadRecords( "db/ellJogHome.db", "BASE=$$PORTBASE:M$$ADDRESS,ADDRESS=$$ADDRESS,PORT=ELL$$PORTINDEX,HOPR=60,EGU=mm,SCALE=1024" )
dbLoadRecords( "db/ellMoveOptimize.db", "BASE=$$PORTBASE:M$$ADDRESS,ADDRESS=$$ADDRESS,PORT=ELL$$PORTINDEX,HOPR=60,EGU=mm,SCALE=1024" )
$$ENDLOOP(ELL20)

$$LOOP(PORT)
dbLoadRecords( "db/ellport.db", "BASE=$$BASE:PORT$$INDEX,PORT=ELL$$INDEX" )
$$ENDLOOP(PORT)

$$LOOP(ALIAS)
dbLoadRecords("db/alias.db", "RECORD=$$RECORD,ALIAS=$$ALIAS")
$$ENDLOOP(ALIAS)

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

# Access Security for caPutLog
asSetFilename("$(IOC_TOP)/iocBoot/templates/default.acf")
 
# Setting the caPutLog file location
caPutLogFile("$(IOC_DATA)/$(IOC)/logs/caPutLog.log")

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOC).req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

# Start caPutLog
# caPutLogInit("HOST:PORT", config)
# config options:
#       caPutLogNone       -1: no logging (disable)
#       caPutLogOnChange    0: log only on value change
#       caPutLogAll         1: log all puts
#       caPutLogAllNoFilter 2: log all puts no filtering on same PV
caPutLogInit("${EPICS_CAPUTLOG_HOST}:${EPICS_CAPUTLOG_PORT}", 0)
