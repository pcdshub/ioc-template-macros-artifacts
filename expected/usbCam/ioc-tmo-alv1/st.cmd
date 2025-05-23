#!/reg/g/pcds/epics/ioc/common/usbCam/R1.0.1/bin/rhel7-x86_64/usb

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

< envPaths
epicsEnvSet( "IOCNAME",      "ioc-tmo-alv1" )
epicsEnvSet( "ENGINEER",     "Michael Browne (mcbrowne)" )
epicsEnvSet( "LOCATION",     "Somewhere in TMO" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "TMO:IOC:ALV:01" )
epicsEnvSet( "IOCTOP",       "/reg/g/pcds/epics/ioc/common/usbCam/R1.0.1" )
epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/common/usbCam/R1.0.1/children/build" )
epicsEnvSet( "EPICS_PVA_AUTO_ADDR_LIST",         "TRUE" )
epicsEnvSet( "EPICS_PVAS_AUTO_BEACON_ADDR_LIST", "TRUE" )
cd( "$(IOCTOP)" )

# Set Max array size
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "20000000" )

# Setup EVR env vars
epicsEnvSet( "EVR_PV",       "TMO:EVR:ALV:1" )
epicsEnvSet( "TRIG_PV",      "$(EVR_PV):TRIG4" )
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
epicsEnvSet( "CAM_IP",       "018NR" )
epicsEnvSet( "CAM_PV",       "TMO:ALV:01" )
epicsEnvSet( "CAM_PORT",     "CAM" )
epicsEnvSet( "MODEL",        "Alvium_1800_U240m" )
epicsEnvSet( "HTTP_PORT",    "7800" )
epicsEnvSet( "N_AD_BUFFERS", "0" )

# Diagnostic settings
epicsEnvSet( "ST_CMD_DELAYS",		"1" )
epicsEnvSet( "CAM_TRACE_MASK",		"1" )
epicsEnvSet( "CAM_TRACE_IO_MASK",	"0" )

# Register all support components
dbLoadDatabase( "dbd/usb.dbd" )
usb_registerRecordDeviceDriver(pdbbase)

# Bump up scanOnce queue size for evr invariant timing
scanOnceSetQueueSize( 4000 )
# Needed for Alvium/ADVimba
callbackSetQueueSize(4000)


# Set iocsh debug variables
var DEBUG_TS_FIFO 1
var save_restoreLogMissingRecords 0

# Setup the environment for the specified camera model
< db/$(MODEL).env

# =========================================================
# Setup environment for this usb type: vimba by default.
# =========================================================
epicsEnvSet( "CAM_TYPE", "vimba" )
< setupScripts/$(CAM_TYPE).cmd

# Set asyn trace flags
asynSetTraceMask(   "$(CAM_PORT)",      0, $(CAM_TRACE_MASK) )
asynSetTraceIOMask( "$(CAM_PORT)",      0, $(CAM_TRACE_IO_MASK) )

# Comment/uncomment/change delay as desired so you can see messages during boot
epicsThreadSleep $(ST_CMD_DELAYS)

# Load the camera model specific template
dbLoadRecords( db/$(MODEL).template, "P=$(CAM_PV),R=:,PORT=$(CAM_PORT),TYPE=$(CAM_TYPE)" )

# Load timestamp plugin
dbLoadRecords("db/timeStampFifo.template",  "DEV=$(CAM_PV):TSS,PORT_PV=$(CAM_PV):PortName_RBV,EC_PV=$(CAM_PV):CamEventCode_RBV,DLY_PV=$(CAM_PV):TrigToTS_Calc NMS CPP" )
#dbLoadRecords("db/timeStampEventCode.db",  "CAM=$(CAM_PV),CAM_TRIG=$(TRIG_PV),TSS=$(CAM_PV):TSS" )

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
ErConfigure( $(EVR_CARD), 0, 0, 0, $(EVRID_SLAC) )
dbLoadRecords( "$(EVRDB)", "IOC=$(IOC_PV),EVR=$(EVR_PV),CARD=$(EVR_CARD),IP4E=Enabled" )
dbLoadRecords( "db/devEvrInfo.db",				"DEV=$(CAM_PV),IOC=$(IOC_PV),EVR=$(EVR_PV),TRIG_CH=4,EVR_USED=1" )

# Load soft ioc related record instances
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/iocRelease.db",			"IOC=$(IOC_PV)" )
epicsEnvSet( "DEV_INFO", "DEV=$(CAM_PV),IOC=$(IOC_PV),IOCNAME=$(IOCNAME)" )
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),COM_TYPE=camLink,COM_PORT=eNet $CAM_IP" )
dbLoadRecords( "db/devIocInfo.db",			"$(DEV_INFO)" )

# Setup autosave
dbLoadRecords( "db/save_restoreStatus.db",	"P=$(IOC_PV),IOC=$(IOC_PV)" )
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
epicsThreadSleep $(ST_CMD_DELAYS)
iocInit()

# iocInit done
epicsThreadSleep $(ST_CMD_DELAYS)

# Start PVAccess Server
#startPVAServer()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req",  5,  "" )
create_monitor_set( "$(IOCNAME).req",    5,  "" )

# All IOCs should dump some common info after initial startup.
< $(IOC_COMMON)/All/post_linux.cmd


epicsThreadSleep $(ST_CMD_DELAYS)

# TODO: Remove these dbpf calls if possible
# Enable callbacks
dbpf $(CAM_PV):ArrayCallbacks 1
dbpf $(CAM_PV):LAUNCH_EDM "/reg/g/pcds/epics/ioc/common/usbCam/R1.0.1/children/build/iocBoot/$(IOCNAME)/edm-$(IOCNAME).cmd"

# Sigh.  Something clobbers these in the camera, so we need to rewrite them here.
epicsThreadSleep 2
dbpf $(CAM_PV):GC_TriggerSelector.PROC 1
epicsThreadSleep 1
dbpf $(CAM_PV):TriggerMode.PROC 1
epicsThreadSleep 1
dbpf $(CAM_PV):TriggerSource.PROC 1
# Final delay before auto-start image acquisition
epicsThreadSleep 3
dbpf $(CAM_PV):Acquire 1
