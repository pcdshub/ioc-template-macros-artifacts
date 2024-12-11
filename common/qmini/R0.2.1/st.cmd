#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/qmini


< envPaths

epicsEnvSet( "ENGINEER" , "$$ENGINEER" )
epicsEnvSet( "IOCSH_PS1", "$$IOCNAME>" )
epicsEnvSet( "IOCENAME", "$$TRANSLATE(IOCNAME,"a-z_-","A-Z::")" )
epicsEnvSet( "IOCPVROOT", "$$IF(IOCPVROOT,$$IOCPVROOT,$(IOCENAME)")
epicsEnvSet( "LOCATION",  "$$IF(LOCATION,$$LOCATION,$$IOCPVROOT)")
epicsEnvSet( "BASE_NAME", "$$NAME"     )
epicsEnvSet( "IOC_TOP",    "$$IOCTOP"   )
epicsEnvSet( "TOP",       "$$TOP"      )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOC_TOP)/qminiApp/srcProtocol" )
epicsEnvSet( "USBPORT", QMINI0 )
epicsEnvSet( "SERIAL", "$$SERIAL" )

# Setup EVR Vars
epicsEnvSet( "EVR_PV",       "$$IF(EVR_PV,$$EVR_PV,$$NAME:NoEvr)" )
epicsEnvSet( "TRIG_PV",      "$(EVR_PV):TRIG$$IF(EVR_TRIG,$$EVR_TRIG,0)" )
epicsEnvSet( "EVR_CARD",     "$$IF(EVR_CARD,$$EVR_CARD,0)" )
# EVR Type: 0=VME, 1=PMC, 15=SLAC
epicsEnvSet( "EVRID_PMC",    "1" )
epicsEnvSet( "EVRID_SLAC",   "15" )
epicsEnvSet( "EVRDB_PMC",    "db/evrPmc230.db" )
epicsEnvSet( "EVRDB_SLAC",   "db/evrSLAC.db" )
$$IF(EVR_TYPE)
epicsEnvSet( "EVRID",        "$(EVRID_$$EVR_TYPE)" )
epicsEnvSet( "EVRDB",        "$(EVRDB_$$EVR_TYPE)" )
$$ENDIF(EVR_TYPE)
epicsEnvSet( "EVR_DEBUG",    "$$IF(EVR_DEBUG,$$EVR_DEBUG,0)" )


cd( "$(IOC_TOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/qmini.dbd")
qmini_registerRecordDeviceDriver(pdbbase)

$$IF(EVR_PV)
ErDebugLevel( 0 )

# Initialize EVR
ErConfigure( $$IF(CARD,$$CARD, 0), 0, 0, 0, $(EVRID_$$EVR_TYPE) )

# Load EVR record instances
dbLoadRecords( $(EVRDB_$$EVR_TYPE), "IOC=$$(IOCPVROOT),EVR=EVR:$$(NAME),CARD=$$IF(CARD,$$CARD,0)" )
dbLoadRecords("db/qmini_evr.db", "BASE=$(BASE_NAME),EVR_TRIG=$(TRIG_PV)" )
$$ENDIF(EVR_PV)


#------------------------------------------------------------------------------
# Asyn support

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1

# Initialize USB Asyn support
#drvAsynUSBPortConfigure(portName, vendorID, productID, "serial_number_string", read_endpoint, write_endpoint)
#drvAsynUSBPortConfigure(QMINI0, 0x276E, 0x0208, "20423", 0x81, 0x01)
drvAsynUSBPortConfigure("$(USBPORT)", 0x276E, 0x0208, "$(SERIAL)", 0x81, 0x01)

asynSetTraceFile( "$(USBPORT)", 0, "$(IOC_DATA)/$(IOC)/iocInfo/asyn.log" )

#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
#asynSetTraceMask( "$(BASE_NAME)", 0, 0xff) # log everything
$$IF(DEBUG,,#)asynSetTraceMask( "$(USBPORT)", 0, 0x19) # log everything
#asynSetTraceIOMask( "$(BASE_NAME)", 0, 2)
$$IF(DEBUG,,#)asynSetTraceIOMask( "$(USBPORT)", 0, 4) # print hex values, not ASCII

## Asyn record support
dbLoadRecords( "db/asynRecord.db","P=$(BASE_NAME),R=,PORT=$(USBPORT),ADDR=0,OMAX=0,IMAX=0")

#------------------------------------------------------------------------------
# Load record instances

#dbLoadRecords( "db/qmini.db",              	"P=$(BASE_NAME), PORT=$(BASE_NAME)" )
dbLoadRecords( "db/qmini.db",              	"P=$(BASE_NAME), PORT=$(USBPORT)" )
dbLoadRecords( "db/iocSoft.db",			"IOC=$(IOCPVROOT)" )
dbLoadRecords( "db/save_restoreStatus.db",	"P=$(IOCPVROOT)" )

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
