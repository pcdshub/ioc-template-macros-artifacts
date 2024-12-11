#!/reg/g/pcds/epics/ioc/common/andorCam/R1.3.0/bin/rhel7-x86_64/andor

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

< envPaths
epicsEnvSet( "IOCNAME",      "ioc-det-andor1" )
epicsEnvSet( "ENGINEER",     "Daniel Damiani (ddamiani)" )
epicsEnvSet( "LOCATION",     "ASC Lab, USB to host daq-det-jungfrau" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "DET:IOC:CAM:ANDOR1" )
epicsEnvSet( "IOCTOP",       "/reg/g/pcds/epics/ioc/common/andorCam/R1.3.0" )
epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/common/andorCam/R1.3.0/children/build" )
epicsEnvSet( "EPICS_PVA_AUTO_ADDR_LIST",         "TRUE" )
epicsEnvSet( "EPICS_PVAS_AUTO_BEACON_ADDR_LIST", "TRUE" )
cd( "$(IOCTOP)" )

# Set Max array size
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "20000000" )

# Set APP
epicsEnvSet( "APP",          "andor" )

epicsEnvSet( "EVR_PV",       "DET:EVR:ANDOR1" )
# Setup EVR env vars
epicsEnvSet( "TRIG_PV",      "$(EVR_PV):TRIG0" )
epicsEnvSet( "EVR_CARD",     "0" )
# EVR Type: 0=VME, 1=PMC, 15=SLAC
epicsEnvSet( "EVRID_PMC",    "1" )
epicsEnvSet( "EVRID_SLAC",   "15" )
epicsEnvSet( "EVRDB_PMC",    "db/evrPmc230.db" )
epicsEnvSet( "EVRDB_SLAC",   "db/evrSLAC.db" )
epicsEnvSet( "EVRID",        "$(EVRID_PMC)" )
epicsEnvSet( "EVRDB",        "$(EVRDB_PMC)" )
epicsEnvSet( "EVR_DEBUG",    "0" )

# Specify camera env variables
epicsEnvSet( "CAM_IP",       "" )
epicsEnvSet( "CAM_PV",       "DET:CAM:ANDOR1" )
epicsEnvSet( "CAM_ID",       "0" )
epicsEnvSet( "MODEL",        "NewtonD0940P" )

epicsEnvSet( "CAM_PORT",     "CAM" )
epicsEnvSet( "HTTP_PORT",    "8001" )
epicsEnvSet( "N_AD_BUFFERS", "0" )

# Diagnostic settings
epicsEnvSet( "ST_CMD_DELAYS",     "1" )
epicsEnvSet( "CAM_TRACE_MASK",    "1" )
epicsEnvSet( "CAM_TRACE_IO_MASK", "0" )

# Register all support components
dbLoadDatabase( "$(IOCTOP)/dbd/andor.dbd" )
andor_registerRecordDeviceDriver(pdbbase)

# Bump up callback and scanOnce queue sizes to handle all the db plumbing in areaDetector IOCs
scanOnceSetQueueSize( 8000 )
callbackSetQueueSize( 8000 )


# Set iocsh debug variables
var DEBUG_TS_FIFO 1
var save_restoreLogMissingRecords 0

# Setup the environment for the specified camera model
< db/$(MODEL).env
# TODO: Move these to $MODEL.env
# Specific values for Andor Newton
#epicsEnvSet( "IMAGE_XSIZE",        "2048"      )
#epicsEnvSet( "IMAGE_YSIZE",        "512"       )
#epicsEnvSet( "IMAGE_NELM",         "1048576"   )   # X*Y (B/W) or X*Y*3 (Color)
# Make IMAGE_NELM be a little bigger than 2048*2048 - MRivers
#epicsEnvSet( "IMAGE_NELM",         "4200000"   )   # X*Y (B/W) or X*Y*3 (Color)

# 32-bit images. 
# This is needed for 32-bit detectors or for 16-bit detectors
# in acccumulate mode if it would overflow 16 bits
#epicsEnvSet( "IMAGE_FTVL",          "LONG"      )
#epicsEnvSet( "IMAGE_TYPE",          "Int32"     )
#epicsEnvSet( "IMAGE_BIT_DEPTH",     "32"        )

# 16-bit images. 
# This can be used for 16-bit detector as long as accumulate mode
# would not result in 16-bit overflow
#epicsEnvSet( "IMAGE_FTVL",          "SHORT"     )
#epicsEnvSet( "IMAGE_TYPE",          "Int16"     )
#epicsEnvSet( "IMAGE_BIT_DEPTH",     "16"        )

# The maximum number of frames buffered in the NDPluginCircularBuff plugin
epicsEnvSet("CBUFFS", "500")

# =========================================================
# Setup environment and configure andor
# =========================================================
epicsEnvSet( "CAM_TYPE", "Andor" )

dbLoadRecords( "db/timeStampEventCode.db", "CAM=$(CAM_PV),TSS=$(CAM_PV):TSS,CAM_TRIG=$(TRIG_PV),CAM_DLY=$(TRIG_PV):TDES" )

# TODO: Move these commands to setupScripts/$(CAM_TYPE).cmd
# andorCCDConfig(const char *portName, const char *installPath, int cameraSerial, int shamrockID,
#                int maxBuffers, size_t maxMemory, int priority, int stackSize)
#andorCCDConfig("$(CAM_PORT)", "/usr/local/etc/andor/", 0, 0, 0, 0, 0 ,0)
# select the camera with serial number 1370
#andorCCDConfig("$(CAM_PORT)", "", 1370, 0, 0, 0, 0, 0)
# select a camera with any serial number
andorCCDConfig("$(CAM_PORT)", "/usr/local/etc/andor/", $(CAM_ID), 0, 0, 0, 0, 0)

# Set asyn trace flags
asynSetTraceMask(   "$(CAM_PORT)",      0, $(CAM_TRACE_MASK) )
asynSetTraceIOMask( "$(CAM_PORT)",      0, $(CAM_TRACE_IO_MASK) )

# Comment/uncomment/change delay as desired so you can see messages during boot
epicsThreadSleep $(ST_CMD_DELAYS)

# Load the camera model specific db file
# Required: CAM, CAM_PORT, CAM_TRIG
# Optional: RES_EGU, RESOLUTION, XO, YO, XRC, YRC, ADDR, TIMEOUT, RATE_SMOOTH
dbLoadRecords( "db/andorCCD.db", "CAM=$(CAM_PV),CAM_PORT=$(CAM_PORT)" )
dbLoadRecords( "db/andorXmitDelay.template", "P=$(CAM_PV),R=:" )
dbLoadRecords( "db/$(MODEL).template", "P=$(CAM_PV),R=:" )
#dbLoadRecords( "db/cannedSequences.db", "CAM=$(CAM_PV),TRIG=$(TRIG_PV):TCTL" )

# Comment out the following lines if there is no Shamrock spectrograph
#shamrockConfig(const char *portName, int shamrockId, const char *iniPath, int priority, int stackSize)
#shamrockConfig("SR1", 0, "", 0, 0)
#dbLoadRecords("db/shamrock.db", "P=$(PREFIX),R=sham1:,PORT=SR1,TIMEOUT=1,PIXELS=1024")
#dbLoadRecords("$(ADANDOR)/db/shamrock.template", "P=$(PREFIX),R=sham1:,PORT=SR1,TIMEOUT=1,PIXELS=1024")

# Load timestamp plugin
dbLoadRecords("db/timeStampFifo.template",  "DEV=$(CAM_PV):TSS,PORT_PV=$(CAM_PV):PortName_RBV,EC_PV=$(CAM_PV):CamEventCode_RBV,DLY_PV=$(CAM_PV):TrigToTS_Calc NMS CPP" )

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

# Configure the EVR
ErDebugLevel( 0 )
ErConfigure( $(EVR_CARD), 0, 0, 0, $(EVRID_PMC) )
dbLoadRecords( "$(EVRDB)", "IOC=$(IOC_PV),EVR=$(EVR_PV),CARD=$(EVR_CARD),IP0E=Enabled" )

# Load both devEvrInfo.db and devTprInfo.db so python programs can test for both sets of PVs
dbLoadRecords( "db/devEvrInfo.db",  "DEV=$(CAM_PV),EVR=$(EVR_PV),TRIG_CH=0,EVR_USED=1" )
dbLoadRecords( "db/devTprInfo.db",  "DEV=$(CAM_PV),TPR_USED=0" )

# Load soft ioc related record instances
dbLoadRecords( "db/iocSoft.db",             "IOC=$(IOC_PV)" )
dbLoadRecords( "db/iocRelease.db",          "IOC=$(IOC_PV)" )
epicsEnvSet( "DEV_INFO", "DEV=$(CAM_PV),IOC=$(IOC_PV),IOCNAME=$(IOCNAME)" )
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),COM_TYPE=USB,COM_PORT= $CAM_IP" )
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),POWER=DET:ASC:PWR:01:Outlet:1:SetAction" )
dbLoadRecords( "db/devIocInfo.db",          "$(DEV_INFO)" )

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
#set_pass0_restoreFile( "$(IOC).sav" )
# Is pass1 needed?
set_pass1_restoreFile( "autoSettings.sav" )
#set_pass1_restoreFile( "$(IOC).sav" )

# Configure access security: this is required for caPutLog.
asSetFilename("$(TOP)/iocBoot/templates/unrestricted.acf")

#
# iocInit: Initialize the IOC and start processing records
#
epicsThreadSleep $(ST_CMD_DELAYS)
iocInit()

# iocInit done

# caPutLogInit("HOST:PORT", config)
# config options:
#       caPutLogNone       -1: no logging (disable)
#       caPutLogOnChange    0: log only on value change
#       caPutLogAll         1: log all puts
#       caPutLogAllNoFilter 2: log all puts no filtering on same PV
caPutLogInit("${EPICS_CA_PUT_LOG_ADDR}", -1)

epicsThreadSleep $(ST_CMD_DELAYS)

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
dbpf $(CAM_PV):LAUNCH_EDM "/reg/g/pcds/epics/ioc/common/andorCam/R1.3.0/children/build/iocBoot/$(IOCNAME)/edm-$(IOCNAME).cmd"

# Final delay before auto-start image acquisition
epicsThreadSleep 3
dbpf $(CAM_PV):Acquire 1
var DEBUG_TS_FIFO 1
