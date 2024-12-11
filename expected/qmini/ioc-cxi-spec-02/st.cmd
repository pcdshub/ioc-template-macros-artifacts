#!/reg/g/pcds/epics/ioc/common/qmini/R1.0.2/bin/rhel7-x86_64/qmini

< envPaths

epicsEnvSet( "ENGINEER" , "kaushikm" )
epicsEnvSet( "IOCSH_PS1", "ioc-cxi-spec-02>" )
epicsEnvSet( "IOCENAME", "IOC:CXI:SPEC:02" )
epicsEnvSet( "IOCPVROOT", "IOC:CXI:LAS:SPL:SP2")
epicsEnvSet( "LOCATION",  "CXI Laser Table")
epicsEnvSet( "BASE_NAME", "CXI:LAS:SPL:SP2"     )
epicsEnvSet( "IOCTOP",    "/reg/g/pcds/epics/ioc/common/qmini/R1.0.2"   )
epicsEnvSet( "TOP",       "/reg/g/pcds/epics/ioc/cxi/qmini/R1.0.0/build"      )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOCTOP)/qminiApp/srcProtocol" )
epicsEnvSet( "USBPORT", QMINI0 )
epicsEnvSet( "SERIAL", "21338" )

# Set APP
epicsEnvSet( "APP",			 "qmini" )

epicsEnvSet( "EVR_PV",       "CXI:LAS:SPL:SP2:NoEvr" )
# Setup EVR Vars
epicsEnvSet( "TRIG_PV",      "$(EVR_PV):TRIG0" )
epicsEnvSet( "EVR_CARD",     "0" )
# EVR Type: 0=VME, 1=PMC, 15=SLAC
epicsEnvSet( "EVRID_PMC",    "1" )
epicsEnvSet( "EVRID_SLAC",   "15" )
epicsEnvSet( "EVRDB_PMC",    "db/evrPmc230.db" )
epicsEnvSet( "EVRDB_SLAC",   "db/evrSLAC.db" )
epicsEnvSet( "EVR_DEBUG",    "0" )

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(IOCTOP)/dbd/qmini.dbd" )
qmini_registerRecordDeviceDriver(pdbbase)

epicsEnvSet( "TIMING_MODE",    "0")  # No timing!
epicsEnvSet( "DEFAULT_EC",     "-1")

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
