#!$$IOCTOP/bin/$$IF(TARGET_ARCH,$$TARGET_ARCH,rhel7-x86_64)/$$IF(APP,$$APP,archon)

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

< envPaths
epicsEnvSet( "IOCNAME",      "$$IOCNAME" )
epicsEnvSet( "ENGINEER",     "$$ENGINEER" )
epicsEnvSet( "LOCATION",     "$$LOCATION" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "$$IOC_PV" )
epicsEnvSet( "IOCTOP",       "$$IOCTOP" )
epicsEnvSet( "BUILD_TOP",    "$$TOP" )
epicsEnvSet( "EPICS_PVA_AUTO_ADDR_LIST",         "TRUE" )
epicsEnvSet( "EPICS_PVAS_AUTO_BEACON_ADDR_LIST", "TRUE" )
cd( "$(IOCTOP)" )

# Set Max array size
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "$$IF(MAX_ARRAY,$$MAX_ARRAY,20000000)" )

# Set APP
epicsEnvSet( "APP",          "$$IF(APP,$$APP,archon)" )

epicsEnvSet( "EVR_PV",       "$$IF(EVR_PV,$$EVR_PV,$$CAM_PV:NoEvr)" )
$$IF(APP,archonTpr)
# Setup TPR env vars
epicsEnvSet( "TPR_CARD",     "$$IF(TPR_CARD,$$TPR_CARD,0)" )
epicsEnvSet( "TPR_PV",       "$$IF(TPR_PV,$$TPR_PV,$$CAM_PV:NoTpr)" )
epicsEnvSet( "TPE_PV",       "$$IF(TPE_PV,$$TPE_PV,$$TPR_PV)" )
epicsEnvSet( "TPR_TR",       "$$IF(TPR_TR,$$TPR_TR,0)" )
epicsEnvSet( "TPR_CH",       "$$IF(TPR_CH,$$TPR_CH,$(TPR_TR))" )
epicsEnvSet( "TPR_SE",       "$$IF(TPR_SE,$$TPR_SE,$(TPR_TR))" )
epicsEnvSet( "TPR_PORT",     "$$IF(TPR_PORT,$$TPR_PORT,trig0)" )
$$ELSE(APP)
# Setup EVR env vars
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
$$ENDIF(APP)

# Specify camera env variables
epicsEnvSet( "CAM_IP_ADDR",  "$$IF(CAM_IP_ADDR,$$CAM_IP_ADDR,10.0.0.2)" )
epicsEnvSet( "CAM_IP_PORT"   "$$IF(CAM_IP_PORT,$$CAM_IP_PORT,4242)" )
$$IF(CAM_PV)
epicsEnvSet( "CAM_PV",       "$$CAM_PV" )
$$ELSE(CAM_PV)
errlog( "CAM_PV not defined" )
exit()
$$ENDIF(CAM_PV)
epicsEnvSet( "CAM_ID",       "$$IF(CAM_ID,$$CAM_ID,0)" )
$$IF(MODEL)
epicsEnvSet( "MODEL",        "$$MODEL" )
$$ELSE(MODEL)
epicsEnvSet( "MODEL",        "UnknownModel" )
$$ENDIF(MODEL)

epicsEnvSet( "CAM_PORT",     "$$IF(PORT,$$PORT,CAM)" )
epicsEnvSet( "HTTP_PORT",    "$$IF(HTTP_PORT,$$HTTP_PORT,7800)" )
epicsEnvSet( "N_AD_BUFFERS", "$$IF(N_AD_BUFFERS,$$N_AD_BUFFERS,0)" )

# Diagnostic settings
epicsEnvSet( "ST_CMD_DELAYS",     "$$IF(ST_CMD_DELAYS,$$ST_CMD_DELAYS,1)" )
epicsEnvSet( "CAM_TRACE_MASK",    "$$IF(CAM_TRACE,$$CAM_TRACE,1)" )
epicsEnvSet( "CAM_TRACE_IO_MASK", "$$IF(CAM_TRACE_IO,$$CAM_TRACE_IO,0)" )

# configuration .acf file to use
epicsEnvSet( "CAM_ACF", "$$IF(CAM_ACF)$$CAM_ACF$$ELSE(CAM_ACF)db/$(MODEL).acf$$ENDIF(CAM_ACF)" )

# Register all support components
$$IF(APP,archonTpr)
dbLoadDatabase( "$(IOCTOP)/dbd/archonTpr.dbd" )
archonTpr_registerRecordDeviceDriver(pdbbase)
$$ELSE(APP)
dbLoadDatabase( "$(IOCTOP)/dbd/archon.dbd" )
archon_registerRecordDeviceDriver(pdbbase)
$$ENDIF(APP)

# Bump up callback and scanOnce queue sizes to handle all the db plumbing in areaDetector IOCs
scanOnceSetQueueSize( $$IF(SCAN_ONCE_QUEUE_SIZE,$$SCAN_ONCE_QUEUE_SIZE,8000) )
callbackSetQueueSize( $$IF(CALLBACK_QUEUE_SIZE,$$CALLBACK_QUEUE_SIZE,8000) )

$$IF(CPU_AFFINITY_SET)
# Set MCoreUtils rules for cpu affinity
mcoreThreadRuleAdd CAM_cpu * * $$CPU_AFFINITY_SET CAM.*
mcoreThreadRuleAdd evr_cpu * * $$CPU_AFFINITY_SET evr.*
$$ENDIF(CPU_AFFINITY_SET)

# Set iocsh debug variables
var DEBUG_TS_FIFO $$IF(DEBUG_TS_FIFO,$$DEBUG_TS_FIFO,1)
var save_restoreLogMissingRecords $$IF(save_restoreLogMissingRecords,$$save_restoreLogMissingRecords,0)

# Setup the environment for the specified camera model
< db/$(MODEL).env

# The maximum number of frames buffered in the NDPluginCircularBuff plugin
epicsEnvSet("CBUFFS", "500")

# =========================================================
# Setup environment and configure archon
# =========================================================
epicsEnvSet( "CAM_TYPE", "$$IF(CAM_TYPE,$$CAM_TYPE,Archon)" )

$$IF(TPR_PV)
# TODO: Do I need all these macros?
dbLoadRecords( "db/timeStampTprEventCode.db", "CAM=$(CAM_PV),TSS=$(CAM_PV):TSS,TPR_PV=$(TPR_PV),TPE_PV=$(TPE_PV),TPR_CH=$(TPR_CH),TPR_TR=$(TPR_TR),TPR_SE=$(TPR_SE),TPR_USED=1" )
$$ELSE(TPR_PV)
dbLoadRecords( "db/timeStampEventCode.db", "CAM=$(CAM_PV),TSS=$(CAM_PV):TSS,CAM_TRIG=$(TRIG_PV),CAM_DLY=$(TRIG_PV):TDES" )
$$ENDIF(TPR_PV)

# TODO: Move these commands to setupScripts/$(CAM_TYPE).cmd
# archonCCDConfig(const char *portName, const char *filePath, const char *cameraAddr, int cameraPort,
#                 int maxBuffers, size_t maxMemory, int priority, int stackSize)
archonCCDConfig("$(CAM_PORT)", "$(CAM_ACF)", "$(CAM_IP_ADDR)", "$(CAM_IP_PORT)", 0, 0, 0, 0)

# Set asyn trace flags
asynSetTraceMask(   "$(CAM_PORT)",      0, $(CAM_TRACE_MASK) )
asynSetTraceIOMask( "$(CAM_PORT)",      0, $(CAM_TRACE_IO_MASK) )
$$IF(USE_TRACE_FILES)
asynSetTraceFile(	"$(CAM_PORT)",		0, "$(IOC_DATA)/$(IOC)/$(CAM_PORT).log" )
$$ENDIF(USE_TRACE_FILES)

$$IF(NO_ST_CMD_DELAY)
$$ELSE(NO_ST_CMD_DELAY)
# Comment/uncomment/change delay as desired so you can see messages during boot
epicsThreadSleep $(ST_CMD_DELAYS)
$$ENDIF(NO_ST_CMD_DELAY)

# Load the camera model specific db file
# Required: CAM, CAM_PORT, CAM_TRIG
# Optional: RES_EGU, RESOLUTION, XO, YO, XRC, YRC, ADDR, TIMEOUT, RATE_SMOOTH
dbLoadRecords( "db/archonCCD.db", "CAM=$(CAM_PV),CAM_PORT=$(CAM_PORT)" )
dbLoadRecords( "db/archonXmitDelay.template", "P=$(CAM_PV),R=:" )
dbLoadRecords( "db/$(MODEL).template", "P=$(CAM_PV),R=:" )
#dbLoadRecords( "db/cannedSequences.db", "CAM=$(CAM_PV),TRIG=$(TRIG_PV):TCTL" )

$$IF(APP,archonTpr)
# TPR driver DB
$$IF(TPE_PV)
dbLoadRecords("db/pcieSlave_tprTrig.db",    "DEV=$$TPE_PV,PORT=$(TPR_PORT)")
$$ELSE(TPE_PV)
dbLoadRecords("db/pcie_tprTrig.db",			"DEV=$$TPR_PV,PORT=$(TPR_PORT)")
$$ENDIF(TPE_PV)
# Load timestamp plugin
dbLoadRecords("db/timeStampFifo.template",  "GIGECAM=1,DEV=$(CAM_PV):TSS,PORT_PV=$(CAM_PV):PortName_RBV,EC_PV=$(CAM_PV):CamEventCode_RBV,GEN_PV=$(CAM_PV):Acquire,DLY_PV=$(CAM_PV):TrigToTS_Calc NMS CPP" )
$$ELSE(APP)
$$IF(EVR_PV)
# Load timestamp plugin
dbLoadRecords("db/timeStampFifo.template",  "DEV=$(CAM_PV):TSS,PORT_PV=$(CAM_PV):PortName_RBV,EC_PV=$(CAM_PV):CamEventCode_RBV,DLY_PV=$(CAM_PV):TrigToTS_Calc NMS CPP" )
$$ENDIF(EVR_PV)
$$ENDIF(APP)

$$IF(NO_ST_CMD_DELAY)
$$ELSE(NO_ST_CMD_DELAY)
epicsThreadSleep $(ST_CMD_DELAYS)
$$ENDIF(NO_ST_CMD_DELAY)

# Provide some reasonable defaults for plugin macros
# May be overridden by $(PLUGINS).cmd
epicsEnvSet( "PLUGIN_SRC", "$(CAM_PORT)" )
epicsEnvSet( "N", "1" )
epicsEnvSet( "QSIZE", "10" )

# Configure and load any image streams
$$LOOP(STREAM)
$$IF(NAME,data)
epicsEnvSet( "IMAGE_NAME",   "$$IF(IMAGE_NAME,$$IMAGE_NAME,DATA1)" )
$$ENDIF(NAME)
$$IF(NAME,viewer)
epicsEnvSet( "IMAGE_NAME",   "$$IF(IMAGE_NAME,$$IMAGE_NAME,IMAGE1)" )
$$ENDIF(NAME)
$$IF(NAME,thumbnail)
epicsEnvSet( "IMAGE_NAME",   "$$IF(IMAGE_NAME,$$IMAGE_NAME,THUMBNAIL)" )
$$ENDIF(NAME)
$$IF(STREAM_NELM)
epicsEnvSet( "STREAM_NELM",  "$$STREAM_NELM" )
$$ELSE(STREAM_NELM)
epicsEnvSet( "STREAM_NELM",  "$(IMAGE_NELM)" )
$$ENDIF(STREAM_NELM)
< db/$$(NAME)Stream.cmd
$$ENDLOOP(STREAM)

# Configure and load any desired viewers (deprecated)
$$LOOP(VIEWER)
epicsEnvSet( "IMAGE_NAME",   "$$IF(IMAGE_NAME,$$IMAGE_NAME,IMAGE1)" )
< db/$$(NAME)Viewer.cmd
$$ENDLOOP(VIEWER)

# Configure and load plugin sets
$$IF(PLUGINS)
< db/$$(PLUGINS).cmd
$$ENDIF(PLUGINS)

# Configure and load selected plugins, if any
$$LOOP(PLUGIN)
epicsEnvSet( "N",            "$$IF(NUM,$$NUM,1)" )
epicsEnvSet( "PLUGIN_SRC",   "$$IF(SRC,$$SRC,CAM)" )
< db/plugin$$(NAME).cmd
$$ENDLOOP(PLUGIN)

$$IF(NO_ST_CMD_DELAY)
$$ELSE(NO_ST_CMD_DELAY)
epicsThreadSleep $(ST_CMD_DELAYS)
$$ENDIF(NO_ST_CMD_DELAY)

$$IF(APP,archonTpr)
$$IF(TPE_PV)
# ====================================
# Setup TPR Driver
# ====================================
tprTriggerAsynDriverConfigure("$(TPR_PORT)", "PCIeSlave:/dev/tpra" )
$$ELSE(TPE_PV)
$$IF(TPR_PV)
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
$$ENDIF(TPR_PV)
$$ENDIF(TPE_PV)

$$ELSE(APP)
$$IF(EVR_PV)
# Configure the EVR
ErDebugLevel( $$IF(ErDebug,$$ErDebug,0) )
ErConfigure( $(EVR_CARD), 0, 0, 0, $(EVRID_$$EVR_TYPE) )
dbLoadRecords( "$(EVRDB)", "IOC=$(IOC_PV),EVR=$(EVR_PV),CARD=$(EVR_CARD)$$IF(EVR_TRIG),IP$$(EVR_TRIG)E=Enabled$$ENDIF(EVR_TRIG)$$LOOP(EXTRA_TRIG),IP$$(TRIG)E=Enabled$$ENDLOOP(EXTRA_TRIG)" )
$$ENDIF(EVR_PV)
$$ENDIF(APP)

# Load both devEvrInfo.db and devTprInfo.db so python programs can test for both sets of PVs
$$IF(EVR_PV)
dbLoadRecords( "db/devEvrInfo.db",  "DEV=$(CAM_PV),EVR=$(EVR_PV),TRIG_CH=$$IF(EVR_TRIG,$$EVR_TRIG,0),EVR_USED=1" )
$$ELSE(EVR_PV)
dbLoadRecords( "db/devEvrInfo.db",  "DEV=$(CAM_PV),EVR=$(EVR_PV),EVR_USED=0" )
$$ENDIF(EVR_PV)
$$IF(TPR_PV)
dbLoadRecords( "db/devTprInfo.db",  "DEV=$(CAM_PV),TPR_PV=$(TPR_PV),TPE_PV=$(TPE_PV),TPR_CH=$(TPR_CH),TPR_TR=$(TPR_TR),TPR_SE=$(TPR_SE),TPR_USED=1" )
$$ELSE(TPR_PV)
dbLoadRecords( "db/devTprInfo.db",  "DEV=$(CAM_PV),TPR_USED=0" )
$$ENDIF(TPR_PV)

# Load soft ioc related record instances
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/iocRelease.db",			"IOC=$(IOC_PV)" )
epicsEnvSet( "DEV_INFO", "DEV=$(CAM_PV),IOC=$(IOC_PV),IOCNAME=$(IOCNAME)" )
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),COM_TYPE=ethernet,COM_PORT= $(CAM_IP_ADDR):$(CAM_IP_PORT)" )
$$IF(POWER)
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),POWER=$$POWER" )
$$ENDIF(POWER)
$$IF(WEB_URL)
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),WEB_URL=$$WEB_URL" )
$$ENDIF(WEB_URL)
$$IF(CAPTAR)
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),CAPTAR=$$CAPTAR" )
$$ENDIF(CAPTAR)
dbLoadRecords( "db/devIocInfo.db",			"$(DEV_INFO)" )

# Setup autosave
dbLoadRecords( "db/save_restoreStatus.db",	"P=$(IOC_PV):SR:" )
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(BUILD_TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):SR:" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
# pass0 autosave restore IS needed for cameras and slows IOC boot
set_pass0_restoreFile( "autoSettings.sav" )
$$IF(USE_IOC_AUTOSAVE,,#)set_pass0_restoreFile( "$(IOCNAME).sav" )
# Is pass1 needed?
set_pass1_restoreFile( "autoSettings.sav" )
$$IF(USE_IOC_AUTOSAVE,,#)set_pass1_restoreFile( "$(IOCNAME).sav" )

# Configure access security: this is required for caPutLog.
asSetFilename("$(TOP)/iocBoot/templates/unrestricted.acf")

#
# iocInit: Initialize the IOC and start processing records
#

$$IF(NO_ST_CMD_DELAY)
$$ELSE(NO_ST_CMD_DELAY)
epicsThreadSleep $(ST_CMD_DELAYS)
$$ENDIF(NO_ST_CMD_DELAY)
iocInit()

# caPutLogInit("HOST:PORT", config)
# config options:
#       caPutLogNone       -1: no logging (disable)
#       caPutLogOnChange    0: log only on value change
#       caPutLogAll         1: log all puts
#       caPutLogAllNoFilter 2: log all puts no filtering on same PV
caPutLogInit("${EPICS_CA_PUT_LOG_ADDR}", -1)

# iocInit done
$$IF(NO_ST_CMD_DELAY)
$$ELSE(NO_ST_CMD_DELAY)
epicsThreadSleep $(ST_CMD_DELAYS)
$$ENDIF(NO_ST_CMD_DELAY)


# Start PVAccess Server
#startPVAServer()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req",  5,  "" )
create_monitor_set( "$(IOCNAME).req",    5,  "" )

# Update archive file
system( "cp $(BUILD_TOP)/archive/$(IOC).archive $(IOC_DATA)/$(IOC)/archive/$(IOC).archive" )

# All IOCs should dump some common info after initial startup.
< $(IOC_COMMON)/All/post_linux.cmd

# TODO: Remove these dbpf calls if possible
# Enable callbacks
dbpf $(CAM_PV):ArrayCallbacks 1
dbpf $(CAM_PV):LAUNCH_EDM "$$TOP/iocBoot/$(IOCNAME)/edm-$(IOCNAME).cmd"

$$IF(AUTO_START)
# Final delay before auto-start image acquisition
epicsThreadSleep 5
system( "$$TOP/iocBoot/$(IOCNAME)/syncts-$(IOCNAME).cmd 1" )
epicsThreadSleep 5
dbpf $(CAM_PV):Acquire $$AUTO_START
$$ENDIF(AUTO_START)
var DEBUG_TS_FIFO $$IF(DEBUG_TS_FIFO,$$DEBUG_TS_FIFO,1)
