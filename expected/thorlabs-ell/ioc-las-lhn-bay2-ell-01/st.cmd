#!/cds/group/pcds/epics/ioc/common/thorlabs-ell/R0.0.6/bin/rhel7-x86_64/ell

< envPaths

epicsEnvSet( "ENGINEER" , "Tyler Johnson (tjohnson)" )
epicsEnvSet( "IOCSH_PS1", "ioc-las-lhn-bay2-ell-01>" )
epicsEnvSet( "IOCPVROOT", "IOC:LAS:LHN:BAY2:ELL:1"   )
epicsEnvSet( "LOCATION",  "LHN Bay 2")
epicsEnvSet( "IOC_TOP",   "/cds/group/pcds/epics/ioc/common/thorlabs-ell/R0.0.6"   )
epicsEnvSet( "TOP",       "/cds/group/pcds/epics/ioc/las/thorlabs-ell/R1.0.0/build"      )
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

drvAsynSerialPortConfigure(ELL0, "/dev/ftdi-DP03UMB9")

#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
#asynSetTraceMask( "ELL0", 0, 0x19) # log everything
#define ASYN_TRACEIO_ASCII  0x0001
#define ASYN_TRACEIO_ESCAPE 0x0002
#define ASYN_TRACEIO_HEX    0x0004
#asynSetTraceIOMask( "ELL0", 0, 2)  # Escape the strings.

## Asyn record support
dbLoadRecords( "db/asynRecord.db","P=LAS:LHN:BAY2:ELL:1,R=,PORT=ELL0,ADDR=0,OMAX=0,IMAX=0")

#------------------------------------------------------------------------------
# Load record instances



dbLoadRecords( "db/ellALL.db", "BASE=LAS:LHN:BAY2:ELL:1:M1,ADDRESS=1,PORT=ELL0,HOPR=60,EGU=mm,SCALE=1024" )
dbLoadRecords( "db/ellJogHome.db", "BASE=LAS:LHN:BAY2:ELL:1:M1,ADDRESS=1,PORT=ELL0,HOPR=60,EGU=mm,SCALE=1024" )
dbLoadRecords( "db/ellMoveOptimize.db", "BASE=LAS:LHN:BAY2:ELL:1:M1,ADDRESS=1,PORT=ELL0,HOPR=60,EGU=mm,SCALE=1024" )

dbLoadRecords( "db/ellport.db", "BASE=LAS:LHN:BAY2:ELL:1:PORT0,PORT=ELL0" )


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
