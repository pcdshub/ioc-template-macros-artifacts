#!/reg/g/pcds/epics/ioc/common/thorlabs-ell/R0.0.7/bin/rhel7-x86_64/ell

< envPaths

epicsEnvSet( "ENGINEER" , "Tyler Johnson (tjohnson)" )
epicsEnvSet( "IOCSH_PS1", "ioc-lm1k4-atm-ell-01>" )
epicsEnvSet( "IOCPVROOT", "IOC:LM1K4:ATM_DP1_TF1_SL1:ELL:0"   )
epicsEnvSet( "LOCATION",  "Heinz Lab (Building 40)")
epicsEnvSet( "IOC_TOP",   "/reg/g/pcds/epics/ioc/common/thorlabs-ell/R0.0.7"   )
epicsEnvSet( "TOP",       "/reg/g/pcds/epics/ioc/common/thorlabs-ell/R0.0.7/children/build"      )
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

drvAsynSerialPortConfigure(ELL0, "/dev/ftdi-DO011T1J")

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
dbLoadRecords( "db/asynRecord.db","P=LM1K4:ATM_DP1_TF1_SL1:ELL,R=,PORT=ELL0,ADDR=0,OMAX=0,IMAX=0")

#------------------------------------------------------------------------------
# Load record instances
dbLoadRecords( "db/ellALL.db", "BASE=LM1K4:ATM_DP1_TF1_SL1:ELL:M1,ADDRESS=1,PORT=ELL0" )
dbLoadRecords( "db/ell6.db", "BASE=LM1K4:ATM_DP1_TF1_SL1:ELL:M1,ADDRESS=1,PORT=ELL0" )




dbLoadRecords( "db/ellport.db", "BASE=LM1K4:ATM_DP1_TF1_SL1:ELL:PORT0,PORT=ELL0" )


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
