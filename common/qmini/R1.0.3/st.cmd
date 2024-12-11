#!$$IOCTOP/bin/$$IF(TARGET_ARCH,$$TARGET_ARCH,rhel7-x86_64)/$$IF(TPR_PV,qminiTpr,qmini)

< envPaths

epicsEnvSet( "ENGINEER" , "$$ENGINEER" )
epicsEnvSet( "IOCSH_PS1", "$$IOCNAME>" )
epicsEnvSet( "IOCENAME", "$$TRANSLATE(IOCNAME,"a-z_-","A-Z::")" )
epicsEnvSet( "IOCPVROOT", "$$IF(IOCPVROOT,$$IOCPVROOT,$(IOCENAME)")
epicsEnvSet( "LOCATION",  "$$IF(LOCATION,$$LOCATION,$$IOCPVROOT)")
epicsEnvSet( "BASE_NAME", "$$NAME"     )
epicsEnvSet( "IOCTOP",    "$$IOCTOP"   )
epicsEnvSet( "TOP",       "$$TOP"      )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOCTOP)/qminiApp/srcProtocol" )
epicsEnvSet( "USBPORT", QMINI0 )
epicsEnvSet( "SERIAL", "$$SERIAL" )

# Set APP
epicsEnvSet( "APP",			 "$$IF(TPR_PV,qminiTpr,qmini)" )

epicsEnvSet( "EVR_PV",       "$$IF(EVR_PV,$$EVR_PV,$$NAME:NoEvr)" )
$$IF(TPR_PV)
# Setup TPR env vars
epicsEnvSet( "TPR_CARD",     "$$IF(TPR_CARD,$$TPR_CARD,0)" )
epicsEnvSet( "TPR_PV",       "$$IF(TPR_PV,$$TPR_PV,$$NAME:NoTpr)" )
epicsEnvSet( "TPE_PV",       "$$IF(TPE_PV,$$TPE_PV,$$TPR_PV)" )
epicsEnvSet( "TPR_TR",       "$$IF(TPR_TR,$$TPR_TR,0)" )
epicsEnvSet( "TPR_CH",       "$$IF(TPR_CH,$$TPR_CH,$(TPR_TR))" )
epicsEnvSet( "TPR_SE",       "$$IF(TPR_SE,$$TPR_SE,$(TPR_TR))" )
epicsEnvSet( "TPR_PORT",     "$$IF(TPR_PORT,$$TPR_PORT,trig0)" )
$$ELSE(TPR_PV)
# Setup EVR Vars
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
$$ENDIF(TPR_PV)

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
$$IF(TPR_PV)
dbLoadDatabase( "$(IOCTOP)/dbd/qminiTpr.dbd" )
qminiTpr_registerRecordDeviceDriver(pdbbase)
$$ELSE(TPR_PV)
dbLoadDatabase( "$(IOCTOP)/dbd/qmini.dbd" )
qmini_registerRecordDeviceDriver(pdbbase)
$$ENDIF(TPR_PV)

$$IF(TPR_PV)
$$IF(TPE_PV)
epicsEnvSet( "TIMING_MODE",    "2")  # TPR
epicsEnvSet( "DEFAULT_EC",   "$$CALC{TPR_CARD+1}0$$IF(TPR_CH,$$TPR_CH,$$TPR_TR)" )
dbLoadRecords("db/pcieSlave_tprTrig.db",    "DEV=$$TPE_PV,PORT=$(TPR_PORT)")

# ====================================
# Setup TPR Driver
# ====================================
tprTriggerAsynDriverConfigure("$(TPR_PORT)", "PCIeSlave:/dev/tpra" )
$$ELSE(TPE_PV)
epicsEnvSet( "TIMING_MODE",    "2")  # TPR
epicsEnvSet( "DEFAULT_EC",   "$(TPR_CARD)0$(TPR_CH)" )

dbLoadRecords("db/pcie_tprTrig.db",	    "DEV=$$TPR_PV,PORT=$(TPR_PORT),NAME=TPR")

# =================================
# Load YAML
# =================================
#epicsThreadSleep(2)
epicsEnvSet("HASH",   "pcie-hash-968bb5f")
epicsEnvSet("YAML_DIR",      "${TOP}/firmware/${HASH}/yaml")
epicsEnvSet("YAML_TOP_FILE", "${YAML_DIR}/000TopLevel.yaml")

# use slot A pcie tpr for root_0, override to use slot_a
cpswLoadYamlFile("${YAML_TOP_FILE}", "MemDev", "", "/dev/tpra", "root_0")

# ====================================
# crossbarControlAsynDriverConfigure  (Pcie master only)
# ====================================
crossbarControlAsynDriverConfigure("crossbar0", "PCIe:/mmio/SfpXbar", "root_0")

# ====================================
# Setup TPR Driver
# ====================================
tprTriggerAsynDriverConfigure("$(TPR_PORT)", "PCIe:/mmio", "root_0")
$$ENDIF(TPE_PV)
$$ELSE(TPR_PV)
$$IF(EVR_PV)
epicsEnvSet( "TIMING_MODE",    "1")  # EVR
epicsEnvSet( "DEFAULT_EC",     "45")
# Configure the EVR
ErDebugLevel( $$IF(ErDebug,$$ErDebug,0) )
ErConfigure( $(EVR_CARD), 0, 0, 0, $(EVRID_$$EVR_TYPE) )
dbLoadRecords( "$(EVRDB)", "IOC=$(IOCPVROOT),EVR=$(EVR_PV),CARD=$(EVR_CARD)$$IF(EVR_TRIG),IP$$(EVR_TRIG)E=Enabled$$ENDIF(EVR_TRIG)$$LOOP(EXTRA_TRIG),IP$$(TRIG)E=Enabled$$ENDLOOP(EXTRA_TRIG)" )
$$ELSE(EVR_PV)
epicsEnvSet( "TIMING_MODE",    "0")  # No timing!
epicsEnvSet( "DEFAULT_EC",     "-1")
$$ENDIF(EVR_PV)
$$ENDIF(TPR_PV)

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
$$IF(DEBUG,,#)asynSetTraceMask( "$(USBPORT)", 0, 0x9) # log everything
$$IF(DEBUG,,#)asynSetTraceIOMask( "$(USBPORT)", 0, 4) # print hex values, not ASCII

## Asyn record support
dbLoadRecords( "db/asynRecord.db","P=$(BASE_NAME),R=,PORT=$(USBPORT),ADDR=0,OMAX=0,IMAX=0")

#------------------------------------------------------------------------------
# Load record instances

dbLoadRecords( "db/qmini.db", "P=$(BASE_NAME),PORT=$(USBPORT),DEFAULT_EC=$(DEFAULT_EC),TIMING_MODE=$(TIMING_MODE),STAGE_CNTL=$$IF(STAGE,1,0)" )
$$IF(TPR_PV)
dbLoadRecords("db/qmini_tpr.db", "P=$(BASE_NAME),TPE_PV=$(TPE_PV),TPR_TR=$(TPR_TR),TPR_CH=$(TPR_CH)" )
$$ELSE(TPR_PV)
$$IF(EVR_PV)
dbLoadRecords("db/qmini_evr.db", "P=$(BASE_NAME),EVR_TRIG=$(TRIG_PV)" )
$$ENDIF(EVR_PV)
$$ENDIF(TPR_PV)

$$IF(STAGE)
dbLoadRecords( "db/adjust.db",              	"P=$(BASE_NAME),STAGE=$$STAGE$$IF(WS),WS=$$WS$$ENDIF(WS)$$IF(WE),WE=$$WE$$ENDIF(WE)$$IF(WL),WL=$$WL$$ENDIF(WL)$$IF(WH),WH=$$WH$$ENDIF(WH)" )
$$IF(SIMSTAGE)
dbLoadRecords( "db/sim.db",                     "STAGE=$$STAGE")
$$ENDIF(SIMSTAGE)
$$ENDIF(STAGE)
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
