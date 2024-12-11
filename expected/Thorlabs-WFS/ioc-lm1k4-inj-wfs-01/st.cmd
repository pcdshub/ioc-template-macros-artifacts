#!/reg/g/pcds/epics/ioc/common/Thorlabs-WFS/R1.0.4/bin/rhel7-gcc494-x86_64/wfs

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

< envPaths
epicsEnvSet( "IOCNAME",      "ioc-lm1k4-inj-wfs-01" )
epicsEnvSet( "ENGINEER",     "Michael Browne (mcbrowne)" )
epicsEnvSet( "LOCATION",     "IP1 MODS Injection TILE" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "IOC:LM1K4:INJ_DP2_TF1_WF1" )
epicsEnvSet( "IOCTOP",       "/reg/g/pcds/epics/ioc/common/Thorlabs-WFS/R1.0.4" )
epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/common/Thorlabs-WFS/R1.0.4/children/build" )
epicsEnvSet( "EPICS_PVA_AUTO_ADDR_LIST",         "TRUE" )
epicsEnvSet( "EPICS_PVAS_AUTO_BEACON_ADDR_LIST", "TRUE" )
cd( "$(IOCTOP)" )

# Set Max array size
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "20000000" )

# Set APP
epicsEnvSet( "APP",			 "wfs" )

epicsEnvSet( "EVR_PV",       "LM1K4:INJ_DP2_TF1_WF1" )
# Setup EVR env vars
epicsEnvSet( "TRIG_PV",      "$(EVR_PV):TRIG8" )
epicsEnvSet( "EVR_CARD",     "0" )
# EVR Type: 0=VME, 1=PMC, 15=SLAC
epicsEnvSet( "EVRID_PMC",    "1" )
epicsEnvSet( "EVRID_SLAC",   "15" )
epicsEnvSet( "EVRDB_PMC",    "db/evrPmc230.db" )
epicsEnvSet( "EVRDB_SLAC",   "db/evrSLAC.db" )
epicsEnvSet( "EVRID",        "$(EVRID_SLAC)" )
epicsEnvSet( "EVRDB",        "$(EVRDB_SLAC)" )
epicsEnvSet( "EVR_DEBUG",    "0" )

# Specify camera env variables
epicsEnvSet( "CAM_ID",       "M00508246" )
epicsEnvSet( "LENSLET_PITCH","150" )
epicsEnvSet( "CAM_PV",       "LM1K4:INJ_DP2_TF1_WF1" )
epicsEnvSet( "CAM_PORT",     "CAM" )
epicsEnvSet( "MODEL",        "WFS-40" )
epicsEnvSet( "HTTP_PORT",    "7800" )
epicsEnvSet( "N_AD_BUFFERS", "0" )
epicsEnvSet( "ARV_DEBUG",    "genicam:1,device:1,chunk:1,dom:1,evaluator:1,stream_thread:1,interface:1,misc:1" )

# Diagnostic settings
epicsEnvSet( "CAM_TRACE_MASK",		"1" )
epicsEnvSet( "CAM_TRACE_IO_MASK",	"0" )

# Register all support components
dbLoadDatabase( "$(IOCTOP)/dbd/wfs.dbd" )
wfs_registerRecordDeviceDriver(pdbbase)

# Set a prefix for the iocLog
iocLogPrefix( "$(IOCNAME): " )

# Bump up scanOnce queue size for evr invariant timing
scanOnceSetQueueSize( 4000 )

# Set iocsh debug variables
var DEBUG_TS_FIFO 1
var save_restoreLogMissingRecords 0

# Setup the environment for the specified camera model
< db/$(MODEL).env

# =========================================================
# Setup environment for this gigE type: aravis or prosilica
# =========================================================
epicsEnvSet( "CAM_TYPE", "ThorlabsWFS")
epicsEnvSet( "CAM_PORT", "CAM" )

dbLoadRecords( "db/timeStampEventCode.db", "CAM=$(CAM_PV),TSS=$(CAM_PV):TSS,CAM_TRIG=$(TRIG_PV),CAM_DLY=$(TRIG_PV):TDES" )

thorlabsWFSConfig("$(CAM_PORT)", "$(CAM_ID)", $(LENSLET_PITCH))

# Set asyn trace flags
asynSetTraceMask(   "$(CAM_PORT)",      0, $(CAM_TRACE_MASK) )
asynSetTraceIOMask( "$(CAM_PORT)",      0, $(CAM_TRACE_IO_MASK) )

dbLoadRecords( "db/$(CAM_TYPE).db",  "CAM=$(CAM_PV),CAM_PORT=$(CAM_PORT)" )
# Load the camera model specific template
dbLoadRecords( db/$(MODEL).template, "P=$(CAM_PV),R=:,PORT=$(CAM_PORT),TYPE=$(CAM_TYPE)" )

# Load timestamp plugin
dbLoadRecords("db/timeStampFifo.template",  "DEV=$(CAM_PV):TSS,PORT_PV=$(CAM_PV):PortName_RBV,EC_PV=$(CAM_PV):CamEventCode_RBV,DLY_PV=$(CAM_PV):TrigToTS_Calc NMS CPP" )

# Provide some reasonable defaults for plugin macros
# May be overridden by $(PLUGINS).cmd
epicsEnvSet( "PLUGIN_SRC", "$(CAM_PORT)" )
epicsEnvSet( "N", "1" )
epicsEnvSet( "QSIZE", "10" )

# We're usually not really interested in the image, but we'll make one here anyway, but no other plugins!
epicsEnvSet( "IMAGE_NAME",   "IMAGE1" )
epicsEnvSet( "STREAM_NELM",  "$(IMAGE_NELM)" )
NDStdArraysConfigure( "$(IMAGE_NAME)",     $(QSIZE), 0, "$(CAM_PORT)", 0, -1 )
dbLoadRecords( "db/viewerStream.db", "CAM=$(CAM_PV),CAM_PORT=$(CAM_PORT),PLUGIN_SRC=$(PLUGIN_SRC),IMAGE_NAME=$(IMAGE_NAME),STREAM_NELM=$(STREAM_NELM),IMAGE_FTVL=$(IMAGE_FTVL),IMAGE_TYPE=Int8" )

# Configure the EVR
ErDebugLevel( 0 )
ErConfigure( $(EVR_CARD), 0, 0, 0, $(EVRID_SLAC) )
dbLoadRecords( "$(EVRDB)", "IOC=$(IOC_PV),EVR=$(EVR_PV),CARD=$(EVR_CARD),IP8E=Enabled" )

# Load both devEvrInfo.db and devTprInfo.db so python programs can test for both sets of PVs
dbLoadRecords( "db/devEvrInfo.db",				"DEV=$(CAM_PV),EVR=$(EVR_PV),TRIG_CH=8,EVR_USED=1" )
dbLoadRecords( "db/devTprInfo.db",	"DEV=$(CAM_PV),TPR_USED=0" )

# Load soft ioc related record instances
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/iocRelease.db",			"IOC=$(IOC_PV)" )
epicsEnvSet( "DEV_INFO", "DEV=$(CAM_PV),IOC=$(IOC_PV),IOCNAME=$(IOCNAME)" )
dbLoadRecords( "db/devIocInfo.db",			"$(DEV_INFO)" )

# Setup autosave
dbLoadRecords( "db/save_restoreStatus.db",	"P=$(IOC_PV):" )
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(BUILD_TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
# pass0 autosave restore IS needed for cameras and slows IOC boot
set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "$(IOC).sav" )
# Is pass1 needed?
set_pass1_restoreFile( "autoSettings.sav" )
set_pass1_restoreFile( "$(IOC).sav" )

#
# iocInit: Initialize the IOC and start processing records
#
iocInit()

# Start PVAccess Server
#startPVAServer()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req",  5,  "" )
create_monitor_set( "$(IOCNAME).req",    5,  "" )

# All IOCs should dump some common info after initial startup.
< $(IOC_COMMON)/All/post_linux.cmd

# TODO: Remove these dbpf calls if possible
# Enable callbacks
dbpf $(CAM_PV):ArrayCallbacks 1
dbpf $(CAM_PV):LAUNCH_EDM "/reg/g/pcds/epics/ioc/common/Thorlabs-WFS/R1.0.4/children/build/iocBoot/$(IOCNAME)/edm-$(IOCNAME).cmd"
