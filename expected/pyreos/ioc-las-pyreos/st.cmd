#!/reg/g/pcds/epics/ioc/common/pyreos/R1.0.0/bin/rhel7-x86_64/pyr

< envPaths

epicsEnvSet( "ENGINEER" , "Michael Browne (mcbrowne)" )
epicsEnvSet( "IOCSH_PS1", "ioc-las-pyreos>" )
epicsEnvSet( "IOCPVROOT", "IOC:LAS:PYR:0"   )
epicsEnvSet( "LOCATION",  "Heinz Lab (Building 40)")
epicsEnvSet( "IOC_TOP",   "/reg/g/pcds/epics/ioc/common/pyreos/R1.0.0"   )
epicsEnvSet( "TOP",       "/reg/g/pcds/epics/ioc/common/pyreos/R1.0.0/children/build"      )
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

pyreosConfigure("/dev/cp210x-0001")
drvAsynSerialPortConfigure(PYR0, "/dev/cp210x-0001")
asynSetOption("PYR0", 0, "baud", "921600")

#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
#asynSetTraceMask( "PYR0", 0, 0x19) # log everything
#define ASYN_TRACEIO_ASCII  0x0001
#define ASYN_TRACEIO_ESCAPE 0x0002
#define ASYN_TRACEIO_HEX    0x0004
#asynSetTraceIOMask( "PYR0", 0, 2)  # Escape the strings.

## Asyn record support
dbLoadRecords( "db/asynRecord.db","P=LAS:PYR,R=,PORT=PYR0,ADDR=0,OMAX=0,IMAX=0")

ErDebugLevel( 0 )

# Initialize EVR
ErConfigure( 0, 0, 0, 0, $(EVRID_SLAC) )

# Load EVR record instances
dbLoadRecords( $(EVRDB_SLAC), "IOC=IOC:LAS:PYR:0,EVR=EVR:LAS:PYR:01,CARD=0,IP6E=Enabled" )

#------------------------------------------------------------------------------
# Load record instances

dbLoadRecords( "db/pyreos.db", "BASE=LAS:PYR,PORT=PYR0,IC=0,CHAN=0,HAVEEVR=1,NELM_CHAR=$(NELM_CHAR_CHAN128_IC1),NELM_DOUBLE=$(NELM_DOUBLE_CHAN128_IC1)" )
dbLoadRecords( "db/pyreos_evr.db", "BASE=LAS:PYR,EVR=EVR:LAS:PYR:01,TRIG=6" )

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
