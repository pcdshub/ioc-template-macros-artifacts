#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/pyr

< envPaths

epicsEnvSet( "ENGINEER" , "$$ENGINEER" )
epicsEnvSet( "IOCSH_PS1", "$$IOCNAME>" )
epicsEnvSet( "IOCPVROOT", "$$IOC_PV"   )
epicsEnvSet( "LOCATION",  "$$IF(LOCATION,$$LOCATION,$$IOC_PV)")
epicsEnvSet( "IOC_TOP",   "$$IOCTOP"   )
epicsEnvSet( "TOP",       "$$TOP"      )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOC_TOP)/app/srcProtocol" )
epicsEnvSet( "NELM_CHAR_CHAN128_IC1", "256")
epicsEnvSet( "NELM_CHAR_CHAN256_IC1", "512")
epicsEnvSet( "NELM_CHAR_CHAN128_IC2", "514")
epicsEnvSet( "NELM_CHAR_CHAN256_IC2", "1026")
epicsEnvSet( "NELM_DOUBLE_CHAN128_IC1", "128")
epicsEnvSet( "NELM_DOUBLE_CHAN256_IC1", "256")
epicsEnvSet( "NELM_DOUBLE_CHAN128_IC2", "256")
epicsEnvSet( "NELM_DOUBLE_CHAN256_IC2", "512")
epicsEnvSet( "EVRID_PMC",    "1" )
epicsEnvSet( "EVRID_SLAC",   "15" )
epicsEnvSet( "EVRDB_PMC",    "db/evrPmc230.db" )
epicsEnvSet( "EVRDB_SLAC",   "db/evrSLAC.db" )

cd( "$(IOC_TOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/pyr.dbd")
pyr_registerRecordDeviceDriver(pdbbase)

#------------------------------------------------------------------------------
# Asyn support

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1

$$LOOP(PYREOS)
pyreosConfigure("/dev/cp210x-$$SERIAL")
drvAsynSerialPortConfigure(PYR$$INDEX, "/dev/cp210x-$$SERIAL")
asynSetOption("PYR$$INDEX", 0, "baud", "921600")

#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
$$IF(DEBUG,,#)asynSetTraceMask( "PYR$$INDEX", 0, 0x19) # log everything
#define ASYN_TRACEIO_ASCII  0x0001
#define ASYN_TRACEIO_ESCAPE 0x0002
#define ASYN_TRACEIO_HEX    0x0004
$$IF(DEBUG,,#)asynSetTraceIOMask( "PYR$$INDEX", 0, 2)  # Escape the strings.

## Asyn record support
dbLoadRecords( "db/asynRecord.db","P=$$BASE,R=,PORT=PYR$$INDEX,ADDR=0,OMAX=0,IMAX=0")
$$ENDLOOP(PYREOS)

ErDebugLevel( 0 )

$$LOOP(EVR)
# Initialize EVR
ErConfigure( $$IF(CARD,$$CARD,$$INDEX), 0, 0, 0, $(EVRID_$$TYPE) )

# Load EVR record instances
dbLoadRecords( $(EVRDB_$$TYPE), "IOC=$$(IOC_PV),EVR=$$(NAME),CARD=$$IF(CARD,$$CARD,$$INDEX)$$LOOP(PYREOS),IP$$(TRIG)E=Enabled$$ENDLOOP(PYREOS)$$LOOP(USETRIG),IP$$(TRIG)E=Enabled$$ENDLOOP(USETRIG)" )
$$ENDLOOP(EVR)

#------------------------------------------------------------------------------
# Load record instances

$$LOOP(PYREOS)
dbLoadRecords( "db/pyreos.db", "BASE=$$BASE,PORT=PYR$$INDEX,IC=$$CALC{IC-1},CHAN=$$CALC{CHAN/128-1},HAVEEVR=$$IF(TRIG,1,0),NELM_CHAR=$(NELM_CHAR_CHAN$$(CHAN)_IC$$IC),NELM_DOUBLE=$(NELM_DOUBLE_CHAN$$(CHAN)_IC$$IC)" )
$$IF(TRIG)
dbLoadRecords( "db/pyreos_evr.db", "BASE=$$BASE,EVR=$$EVRNAME,TRIG=$$TRIG" )
$$ENDIF(TRIG)
$$ENDLOOP(PYREOS)

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
