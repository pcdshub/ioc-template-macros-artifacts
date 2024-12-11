#!/reg/g/pcds/epics/ioc/common/visar/R1.0.3/bin/rhel7-x86_64/visarCamera

< envPaths

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

epicsEnvSet( "IOCNAME",      "ioc-mec-streak-02" )
epicsEnvSet( "ENGINEER" , "joaoprod" )
epicsEnvSet( "LOCATION",     "MEC" )
epicsEnvSet( "IOCSH_PS1", "ioc-mec-streak-02>" )
epicsEnvSet( "IOC_PV",       "IOC:MEC:STREAK:02" )
epicsEnvSet( "IOCTOP",    "/reg/g/pcds/epics/ioc/common/visar/R1.0.3"   )
epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/mec/visar/R1.0.4/build" )
cd( "$(IOCTOP)" )

#epicsEnvSet( "IOC",       "IOC:MEC:STREAK:02" )

epicsEnvSet( "CAM_PV",       "MEC:STREAK:02" )

# Set Max array size
#epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "20000000" )
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "20000000" )

epicsEnvSet( "VISAR_IP",      "172.21.46.88"       )
epicsEnvSet( "VISAR_PORT_C",	  "1001"     )
epicsEnvSet( "VISAR_PORT_D",	  "1002"     )
epicsEnvSet( "VISAR_CAL_FILE",	  "/reg/g/pcds/epics/ioc/mec/visar/R1.0.4/VISAR2.txt"     )


# Setup EVR env vars
epicsEnvSet( "EVR_PV",       "EVR:MEC:STREAK:02" )
epicsEnvSet( "TRIG_PV",      "$(EVR_PV):TRIG1" )
epicsEnvSet( "EVR_CARD",     "0" )

# EVR Type: 0=VME, 1=PMC, 15=SLAC
epicsEnvSet( "EVRID_PMC",    "1" )
epicsEnvSet( "EVRID_SLAC",   "15" )
epicsEnvSet( "EVRDB_PMC",    "db/evrPmc230.db" )
epicsEnvSet( "EVRDB_SLAC",   "db/evrSLAC.db" )
epicsEnvSet( "EVRID",        "$(EVRID_SLAC)" )
epicsEnvSet( "EVRDB",        "$(EVRDB_SLAC)" )
#epicsEnvSet( "EVR_DEBUG",    "" )


epicsEnvSet( "STREAM_PROTOCOL_PATH", "db" )
epicsEnvSet( "EPICS_DB_INCLUDE_PATH","$(ADCORE)/db" )


# Bump up scanOnce queue size for evr invariant timing
scanOnceSetQueueSize( 4000 )


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
dbLoadRecords( "db/visarCamera.db", "CAM=$(CAM_PV),PORTC=PORT_C,PORTD=PORT_D,PORT=ADVISAR,ADDR=0,TIMEOUT=1,CAM_TRIG=EVR:MEC:USR01:TRIG4")

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

dbLoadRecords( "$(EVRDB)", "IOC=$(IOC_PV),EVR=$(EVR_PV),CARD=$(EVR_CARD),IP1E=Enabled" )

dbLoadRecords( "db/shadowEvr.db", "LOCAL=EVR:MEC:STREAK:02:TRIG1,REMOTE=EVR:MEC:USR01:TRIG4,CAM=$(CAM_PV)" )

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

dbpf $(CAM_PV):Acquire,0
#dbpf $(CAM_PV):CamEventCode,182
