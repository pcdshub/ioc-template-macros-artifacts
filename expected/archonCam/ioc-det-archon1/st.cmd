#!/reg/g/pcds/epics/ioc/common/archonCam/R1.1.0/bin/rhel7-x86_64/archonTpr

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

< envPaths
epicsEnvSet( "IOCNAME",      "ioc-det-archon1" )
epicsEnvSet( "ENGINEER",     "Daniel Damiani (ddamiani)" )
epicsEnvSet( "LOCATION",     "ASC Lab, ethernet to host daq-det-standalone" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "DET:IOC:CAM:ARCHON:01" )
epicsEnvSet( "IOCTOP",       "/reg/g/pcds/epics/ioc/common/archonCam/R1.1.0" )
epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/common/archonCam/R1.1.0/children/build" )
epicsEnvSet( "EPICS_PVA_AUTO_ADDR_LIST",         "TRUE" )
epicsEnvSet( "EPICS_PVAS_AUTO_BEACON_ADDR_LIST", "TRUE" )
cd( "$(IOCTOP)" )

# Set Max array size
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "20000000" )

# Set APP
epicsEnvSet( "APP",          "archonTpr" )

epicsEnvSet( "EVR_PV",       "DET:CAM:ARCHON:01:NoEvr" )
# Setup TPR env vars
epicsEnvSet( "TPR_CARD",     "0" )
epicsEnvSet( "TPR_PV",       "DET:ASC:TPR:01" )
epicsEnvSet( "TPE_PV",       "DET:CAM:ARCHON:01:TPE" )
epicsEnvSet( "TPR_TR",       "00" )
epicsEnvSet( "TPR_CH",       "$(TPR_TR)" )
epicsEnvSet( "TPR_SE",       "$(TPR_TR)" )
epicsEnvSet( "TPR_PORT",     "trig0" )

# Specify camera env variables
epicsEnvSet( "CAM_IP_ADDR",  "10.0.0.2" )
epicsEnvSet( "CAM_IP_PORT"   "4242" )
epicsEnvSet( "CAM_PV",       "DET:CAM:ARCHON:01" )
epicsEnvSet( "CAM_ID",       "0" )
epicsEnvSet( "MODEL",        "STA5200" )

epicsEnvSet( "CAM_PORT",     "CAM" )
epicsEnvSet( "HTTP_PORT",    "8001" )
epicsEnvSet( "N_AD_BUFFERS", "0" )

# Diagnostic settings
epicsEnvSet( "ST_CMD_DELAYS",     "1" )
epicsEnvSet( "CAM_TRACE_MASK",    "1" )
epicsEnvSet( "CAM_TRACE_IO_MASK", "0" )

# configuration .acf file to use
epicsEnvSet( "CAM_ACF", "db/$(MODEL).acf" )

# Register all support components
dbLoadDatabase( "$(IOCTOP)/dbd/archonTpr.dbd" )
archonTpr_registerRecordDeviceDriver(pdbbase)

# Bump up callback and scanOnce queue sizes to handle all the db plumbing in areaDetector IOCs
scanOnceSetQueueSize( 8000 )
callbackSetQueueSize( 8000 )


# Set iocsh debug variables
var DEBUG_TS_FIFO 1
var save_restoreLogMissingRecords 0

# Setup the environment for the specified camera model
< db/$(MODEL).env

# The maximum number of frames buffered in the NDPluginCircularBuff plugin
epicsEnvSet("CBUFFS", "500")

# =========================================================
# Setup environment and configure archon
# =========================================================
epicsEnvSet( "CAM_TYPE", "Archon" )

# TODO: Do I need all these macros?
dbLoadRecords( "db/timeStampTprEventCode.db", "CAM=$(CAM_PV),TSS=$(CAM_PV):TSS,TPR_PV=$(TPR_PV),TPE_PV=$(TPE_PV),TPR_CH=$(TPR_CH),TPR_TR=$(TPR_TR),TPR_SE=$(TPR_SE),TPR_USED=1" )

# TODO: Move these commands to setupScripts/$(CAM_TYPE).cmd
# archonCCDConfig(const char *portName, const char *filePath, const char *cameraAddr, int cameraPort,
#                 int maxBuffers, size_t maxMemory, int priority, int stackSize)
archonCCDConfig("$(CAM_PORT)", "$(CAM_ACF)", "$(CAM_IP_ADDR)", "$(CAM_IP_PORT)", 0, 0, 0, 0)

# Set asyn trace flags
asynSetTraceMask(   "$(CAM_PORT)",      0, $(CAM_TRACE_MASK) )
asynSetTraceIOMask( "$(CAM_PORT)",      0, $(CAM_TRACE_IO_MASK) )

# Comment/uncomment/change delay as desired so you can see messages during boot
epicsThreadSleep $(ST_CMD_DELAYS)

# Load the camera model specific db file
# Required: CAM, CAM_PORT, CAM_TRIG
# Optional: RES_EGU, RESOLUTION, XO, YO, XRC, YRC, ADDR, TIMEOUT, RATE_SMOOTH
dbLoadRecords( "db/archonCCD.db", "CAM=$(CAM_PV),CAM_PORT=$(CAM_PORT)" )
dbLoadRecords( "db/archonXmitDelay.template", "P=$(CAM_PV),R=:" )
dbLoadRecords( "db/$(MODEL).template", "P=$(CAM_PV),R=:" )
#dbLoadRecords( "db/cannedSequences.db", "CAM=$(CAM_PV),TRIG=$(TRIG_PV):TCTL" )

# TPR driver DB
dbLoadRecords("db/pcieSlave_tprTrig.db",    "DEV=DET:CAM:ARCHON:01:TPE,PORT=$(TPR_PORT)")
# Load timestamp plugin
dbLoadRecords("db/timeStampFifo.template",  "GIGECAM=1,DEV=$(CAM_PV):TSS,PORT_PV=$(CAM_PV):PortName_RBV,EC_PV=$(CAM_PV):CamEventCode_RBV,GEN_PV=$(CAM_PV):Acquire,DLY_PV=$(CAM_PV):TrigToTS_Calc NMS CPP" )

epicsThreadSleep $(ST_CMD_DELAYS)

# Provide some reasonable defaults for plugin macros
# May be overridden by $(PLUGINS).cmd
epicsEnvSet( "PLUGIN_SRC", "$(CAM_PORT)" )
epicsEnvSet( "N", "1" )
epicsEnvSet( "QSIZE", "10" )

# Configure and load any image streams
epicsEnvSet( "IMAGE_NAME",   "IMAGE1" )
epicsEnvSet( "STREAM_NELM",  "$(IMAGE_NELM)" )
< db/dataStream.cmd
epicsEnvSet( "IMAGE_NAME",   "IMAGE2" )
epicsEnvSet( "STREAM_NELM",  "$(IMAGE_NELM)" )
< db/viewerStream.cmd
epicsEnvSet( "IMAGE_NAME",   "THUMBNAIL" )
epicsEnvSet( "STREAM_NELM",  "$(IMAGE_NELM)" )
< db/thumbnailStream.cmd

# Configure and load any desired viewers (deprecated)

# Configure and load plugin sets
< db/commonPlugins.cmd

# Configure and load selected plugins, if any

epicsThreadSleep $(ST_CMD_DELAYS)

# ====================================
# Setup TPR Driver
# ====================================
tprTriggerAsynDriverConfigure("$(TPR_PORT)", "PCIeSlave:/dev/tpra" )


# Load both devEvrInfo.db and devTprInfo.db so python programs can test for both sets of PVs
dbLoadRecords( "db/devEvrInfo.db",  "DEV=$(CAM_PV),EVR=$(EVR_PV),EVR_USED=0" )
dbLoadRecords( "db/devTprInfo.db",  "DEV=$(CAM_PV),TPR_PV=$(TPR_PV),TPE_PV=$(TPE_PV),TPR_CH=$(TPR_CH),TPR_TR=$(TPR_TR),TPR_SE=$(TPR_SE),TPR_USED=1" )

# Load soft ioc related record instances
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/iocRelease.db",			"IOC=$(IOC_PV)" )
epicsEnvSet( "DEV_INFO", "DEV=$(CAM_PV),IOC=$(IOC_PV),IOCNAME=$(IOCNAME)" )
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),COM_TYPE=ethernet,COM_PORT= $(CAM_IP_ADDR):$(CAM_IP_PORT)" )
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),POWER=DET:ASC:PWR:01:Outlet:1:SetAction" )
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
#set_pass0_restoreFile( "$(IOCNAME).sav" )
# Is pass1 needed?
set_pass1_restoreFile( "autoSettings.sav" )
#set_pass1_restoreFile( "$(IOCNAME).sav" )

# Configure access security: this is required for caPutLog.
asSetFilename("$(TOP)/iocBoot/templates/unrestricted.acf")

#
# iocInit: Initialize the IOC and start processing records
#

epicsThreadSleep $(ST_CMD_DELAYS)
iocInit()

# caPutLogInit("HOST:PORT", config)
# config options:
#       caPutLogNone       -1: no logging (disable)
#       caPutLogOnChange    0: log only on value change
#       caPutLogAll         1: log all puts
#       caPutLogAllNoFilter 2: log all puts no filtering on same PV
caPutLogInit("${EPICS_CA_PUT_LOG_ADDR}", -1)

# iocInit done
epicsThreadSleep $(ST_CMD_DELAYS)


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
dbpf $(CAM_PV):LAUNCH_EDM "/reg/g/pcds/epics/ioc/common/archonCam/R1.1.0/children/build/iocBoot/$(IOCNAME)/edm-$(IOCNAME).cmd"

# Final delay before auto-start image acquisition
epicsThreadSleep 5
system( "/reg/g/pcds/epics/ioc/common/archonCam/R1.1.0/children/build/iocBoot/$(IOCNAME)/syncts-$(IOCNAME).cmd 1" )
epicsThreadSleep 5
dbpf $(CAM_PV):Acquire 1
var DEBUG_TS_FIFO 1
