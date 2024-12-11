#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,rhel6-x86_64)/visarCamera

< envPaths

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

epicsEnvSet( "IOCNAME",      "$$IOCNAME" )
epicsEnvSet( "ENGINEER" , "$$ENGINEER" )
epicsEnvSet( "LOCATION",     "$$LOCATION" )
epicsEnvSet( "IOCSH_PS1", "$$IOCNAME>" )
epicsEnvSet( "IOC_PV",       "$$IOC_PV" )
epicsEnvSet( "IOCTOP",    "$$IOCTOP"   )
epicsEnvSet( "BUILD_TOP",    "$$TOP" )
cd( "$(IOCTOP)" )

#epicsEnvSet( "IOC",       "$$IOC_PV" )

$$IF(CAM_PV)
epicsEnvSet( "CAM_PV",       "$$CAM_PV" )
$$ELSE(CAM_PV)
errlog( "CAM_PV not defined" )
exit()
$$ENDIF(CAM_PV)

# Set Max array size
#epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "$$IF(MAX_ARRAY,$$MAX_ARRAY,20000000)" )
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "20000000" )

epicsEnvSet( "VISAR_IP",      "$$VISAR_IP"       )
epicsEnvSet( "VISAR_PORT_C",	  "$$VISAR_PORT_C"     )
epicsEnvSet( "VISAR_PORT_D",	  "$$VISAR_PORT_D"     )
epicsEnvSet( "VISAR_CAL_FILE",	  "$$VISAR_CAL_FILE"     )


# Setup EVR env vars
epicsEnvSet( "EVR_PV",       "$$IF(EVR_PV,$$EVR_PV,$$CAM_PV:NoEvr)" )
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
#epicsEnvSet( "EVR_DEBUG",    "$$IF(EVR_DEBUG,$$EVR_DEBUG,)" )


epicsEnvSet( "STREAM_PROTOCOL_PATH", "db" )
epicsEnvSet( "EPICS_DB_INCLUDE_PATH","$(ADCORE)/db" )


# Bump up scanOnce queue size for evr invariant timing
scanOnceSetQueueSize( $$IF(SCAN_ONCE_QUEUE_SIZE,$$SCAN_ONCE_QUEUE_SIZE,4000) )


dbLoadDatabase( "dbd/visarCamera.dbd" )
visarCamera_registerRecordDeviceDriver(pdbbase)

# Configure asyn ports
drvAsynIPPortConfigure( "PORT_C","$(VISAR_IP):$(VISAR_PORT_C)", 0, 0, 0)
drvAsynIPPortConfigure( "PORT_D","$(VISAR_IP):$(VISAR_PORT_D)", 0, 0, 0)
dbLoadRecords(	"db/asynRecord.db",			"P=$(CAM_PV),R=:PORT_C:AsynIO,PORT=PORT_C,ADDR=0,IMAX=0,OMAX=0" )
dbLoadRecords(	"db/asynRecord.db",			"P=$(CAM_PV),R=:PORT_D:AsynIO,PORT=PORT_D,ADDR=0,IMAX=0,OMAX=0" )


asynSetTraceFile( "PORT_C", 0, "$(IOC_DATA)/$(IOC)/iocInfo/asynControlPort.log" )
asynSetTraceFile( "PORT_D", 0, "$(IOC_DATA)/$(IOC)/iocInfo/asynDataPort.log" )
#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010

#asynSetTraceMask( "PORT_C", 0, 0xff) # log everything
#asynSetTraceIOMask( "PORT_C", 0, 2)

#asynSetTraceMask( "PORT_D", 0, 0xff) # log everything
#asynSetTraceIOMask( "PORT_D", 0, 2)


epicsThreadSleep(1.0)

# Load record instances
dbLoadRecords( "db/visarCamera.db", "CAM=$(CAM_PV),PORTC=PORT_C,PORTD=PORT_D,PORT=ADVISAR,ADDR=0,TIMEOUT=1,CAM_TRIG=$$IF(REAL_EVR_PV)$$REAL_EVR_PV:TRIG$$REAL_EVR_TRIG$$ELSE(REAL_EVR_PV)$$EVR_PV:TRIG$$EVR_TRIG$$ENDIF(REAL_EVR_PV)")

# Load soft ioc related record instances
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )

# Setup autosave
dbLoadRecords( "db/save_restoreStatus.db",	"IOC=$(IOC_PV)" )
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(BUILD_TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "autoSettings.sav" )
set_pass1_restoreFile( "$(IOC).sav" )

# Load timestamp plugin
dbLoadRecords("db/timeStampFifo.template",  "DEV=$(CAM_PV):TSS,PORT_PV=$(CAM_PV):PortName_RBV,EC_PV=$(CAM_PV):CamEventCode_RBV,DLY_PV=$(CAM_PV):TrigToTS_Calc NMS CPP" )

# Configure the EVR
ErDebugLevel( 0 )
ErConfigure( $(EVR_CARD), 0, 0, 0, $(EVRID) )

dbLoadRecords( "$(EVRDB)", "IOC=$(IOC_PV),EVR=$(EVR_PV),CARD=$(EVR_CARD)$$IF(EVR_TRIG),IP$$(EVR_TRIG)E=Enabled$$ENDIF(EVR_TRIG)$$LOOP(EXTRA_TRIG),IP$$(TRIG)E=Enabled$$ENDLOOP(EXTRA_TRIG)" )

$$IF(REAL_EVR_PV)
dbLoadRecords( "db/shadowEvr.db", "LOCAL=$$EVR_PV:TRIG$$EVR_TRIG,REMOTE=$$REAL_EVR_PV:TRIG$$REAL_EVR_TRIG,CAM=$(CAM_PV)" )
$$ENDIF(REAL_EVR_PV)

visarCameraConfig( "ADVISAR", "PORT_C", "PORT_D" , -1,-1)

# 1344 * 1024
epicsEnvSet("NELEMENTS", "1376256")

# Create a standard arrays plugin
NDStdArraysConfigure("Image1", 3, 0, "ADVISAR", 0, 0)
dbLoadRecords("$(ADCORE)/db/NDStdArrays.template", "P=$(CAM_PV):,R=IMAGE1:,PORT=Image1,ADDR=0,TIMEOUT=1,NDARRAY_PORT=ADVISAR,NDARRAY_ADDR=0,TYPE=Int16,FTVL=SHORT,NELEMENTS=$(NELEMENTS)")

# Initialize the IOC and start processing records
iocInit()

# Wait for enum callbacks to complete
epicsThreadSleep(1.0)

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req",  5,  "" )
create_monitor_set( "$(IOCNAME).req",    5,  "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

dbpf $(CAM_PV):ScalingFilePath,$(VISAR_CAL_FILE)

epicsThreadSleep(3)
dbpf $(CAM_PV):DoInit.PROC 1
epicsThreadSleep(3)

dbpf $(CAM_PV):IMAGE1:EnableCallbacks,1
dbpf $(CAM_PV):ArrayCallbacks,1

#dbpf $(CAM_PV):AcquireTime,.02

dbpf $(CAM_PV):Acquire,$$IF(AUTO_START,$$AUTO_START,0)
#dbpf $(CAM_PV):CamEventCode,182
