#!/cds/group/pcds/epics/ioc/common/qmini/R1.0.3/bin/rhel7-x86_64/qminiTpr

< envPaths

epicsEnvSet( "ENGINEER" , "tjohnson" )
epicsEnvSet( "IOCSH_PS1", "ioc-las-lln-spec-01>" )
epicsEnvSet( "IOCENAME", "IOC:LAS:LLN:SPEC:01" )
epicsEnvSet( "IOCPVROOT", "IOC:LAS:LLN:QMINI:01")
epicsEnvSet( "LOCATION",  "NEH Laser Lab")
epicsEnvSet( "BASE_NAME", "LAS:LLN:QMINI:01"     )
epicsEnvSet( "IOCTOP",    "/cds/group/pcds/epics/ioc/common/qmini/R1.0.3"   )
epicsEnvSet( "TOP",       "/cds/group/pcds/epics/ioc/las/qmini/R1.0.1/build"      )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOCTOP)/qminiApp/srcProtocol" )
epicsEnvSet( "USBPORT", QMINI0 )
epicsEnvSet( "SERIAL", "22323" )

# Set APP
epicsEnvSet( "APP",			 "qminiTpr" )

epicsEnvSet( "EVR_PV",       "LAS:LLN:QMINI:01:NoEvr" )
# Setup TPR env vars
epicsEnvSet( "TPR_CARD",     "0" )
epicsEnvSet( "TPR_PV",       "LLN:TPR:02" )
epicsEnvSet( "TPE_PV",       "LAS:LLN:QMINI:01:TPE" )
epicsEnvSet( "TPR_TR",       "03" )
epicsEnvSet( "TPR_CH",       "$(TPR_TR)" )
epicsEnvSet( "TPR_SE",       "$(TPR_TR)" )
epicsEnvSet( "TPR_PORT",     "trig0" )

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(IOCTOP)/dbd/qminiTpr.dbd" )
qminiTpr_registerRecordDeviceDriver(pdbbase)

epicsEnvSet( "TIMING_MODE",    "2")  # TPR
epicsEnvSet( "DEFAULT_EC",   "1003" )
dbLoadRecords("db/pcieSlave_tprTrig.db",    "DEV=LAS:LLN:QMINI:01:TPE,PORT=$(TPR_PORT)")

# ====================================
# Setup TPR Driver
# ====================================
tprTriggerAsynDriverConfigure("$(TPR_PORT)", "PCIeSlave:/dev/tpra" )

#------------------------------------------------------------------------------
# Asyn support

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1

# Initialize USB Asyn support
drvAsynUSBPortConfigure("$(USBPORT)", 0x276E, 0x0208, "$(SERIAL)", 0x81, 0x01)

asynSetTraceFile( "$(USBPORT)", 0, "$(IOC_DATA)/$(IOC)/iocInfo/asyn.log" )

#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
#asynSetTraceMask( "$(USBPORT)", 0, 0x9) # log everything
#asynSetTraceIOMask( "$(USBPORT)", 0, 4) # print hex values, not ASCII

## Asyn record support
dbLoadRecords( "db/asynRecord.db","P=$(BASE_NAME),R=,PORT=$(USBPORT),ADDR=0,OMAX=0,IMAX=0")

#------------------------------------------------------------------------------
# Load record instances

dbLoadRecords( "db/qmini.db", "P=$(BASE_NAME),PORT=$(USBPORT),DEFAULT_EC=$(DEFAULT_EC),TIMING_MODE=$(TIMING_MODE),STAGE_CNTL=0" )
dbLoadRecords("db/qmini_tpr.db", "P=$(BASE_NAME),TPE_PV=$(TPE_PV),TPR_TR=$(TPR_TR),TPR_CH=$(TPR_CH)" )

dbLoadRecords( "db/iocSoft.db",			"IOC=$(IOCPVROOT)" )
dbLoadRecords( "db/save_restoreStatus.db",	"P=$(IOCPVROOT):" )

#------------------------------------------------------------------------------
# Setup autosave

set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
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
