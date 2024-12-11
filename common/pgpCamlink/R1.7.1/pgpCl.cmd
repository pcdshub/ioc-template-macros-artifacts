#!$$IOCTOP/bin/$$IF(TARGET_ARCH,$$TARGET_ARCH,rhel7-x86_64)/$$EXE

$$IF(IOC_COMMON)
# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd
$$ENDIF(IOC_COMMON)

epicsEnvSet( "TOP",          "$$TOP" )
< envPaths
epicsEnvSet( "IOCNAME",      "$$IOCNAME" )
epicsEnvSet( "ENGINEER",     "$$ENGINEER" )
epicsEnvSet( "LOCATION",     "$$LOCATION" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "$$IOC_PV" )
epicsEnvSet( "IOCTOP",       "$$IOCTOP" )
epicsEnvSet( "EPICS_PVA_AUTO_ADDR_LIST",         "TRUE" )
epicsEnvSet( "EPICS_PVAS_AUTO_BEACON_ADDR_LIST", "TRUE" )

# Set Max array size
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "$$IF(MAX_ARRAY,$$MAX_ARRAY,20000000)" )

# Specify PGP_PV
$$IF(PGP_PV)
epicsEnvSet( "PGP_PV",       "$$PGP_PV" )
$$ELSE(PGP_PV)
errlog( "Error: PGP_PV not defined" )
$$ENDIF(PGP_PV)

# Specify PGP_PORT
epicsEnvSet( "PGP_PORT",     "$$IF(PGP_PORT,$$PGP_PORT,PGP)" )
epicsEnvSet( "PGP_BOARD",    "$$IF(PGP_BOARD,$$PGP_BOARD,0)" )

cd( "$(IOCTOP)" )

$$IF(CAM_PV)
# Specify camera env variables
epicsEnvSet( "CAM_PV",       "$$CAM_PV" )
epicsEnvSet( "CAM_PORT",     "$$IF(PORT,$$PORT,CAM)" )
epicsEnvSet( "MODEL",        "$$MODEL" )
epicsEnvSet( "HTTP_PORT",    "$$IF(HTTP_PORT,$$HTTP_PORT,7800)" )
epicsEnvSet( "N_AD_BUFFERS", "$$IF(N_AD_BUFFERS,$$N_AD_BUFFERS,0)" )
# Default pgpCamlinkDriver settings
epicsEnvSet( "PGP_LANE",     		 "$$IF(PGP_LANE,$$PGP_LANE,0)" )
epicsEnvSet( "CAMLINK_MODE",         "$$IF(CAMLINK_MODE,$$CAMLINK_MODE,Base)" )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$$IF(STREAM_PROTOCOL_PATH,$$STREAM_PROTOCOL_PATH,db)" )
$$ELSE(CAM_PV)
errlog( "Error: CAM_PV not defined" )
exit()
$$ENDIF(CAM_PV)

# Diagnostic settings
epicsEnvSet( "ST_CMD_DELAYS",		"$$IF(ST_CMD_DELAYS,$$ST_CMD_DELAYS,1)" )
epicsEnvSet( "CAM_TRACE_MASK",		"$$IF(CAM_TRACE_MASK,$$CAM_TRACE_MASK,1)" )
epicsEnvSet( "CAM_TRACE_IO_MASK",	"$$IF(CAM_TRACE_IO_MASK,$$CAM_TRACE_IO_MASK,0)" )
epicsEnvSet( "SER_TRACE_MASK",	    "$$IF(SER_TRACE_MASK,$$SER_TRACE_MASK,1)" )
epicsEnvSet( "SER_TRACE_IO_MASK",	"$$IF(SER_TRACE_IO_MASK,$$SER_TRACE_IO_MASK,0)" )

# Register support components
dbLoadDatabase( "dbd/pgpCl.dbd" )
pgpCl_registerRecordDeviceDriver(pdbbase)

$$IF(CPU_AFFINITY_SET)
# Set MCoreUtils rules for cpu affinity
mcoreThreadRuleAdd CAM_cpu * * $$CPU_AFFINITY_SET CAM.*
$$ENDIF(CPU_AFFINITY_SET)

# Set iocsh debug variables
var streamDebug $$IF(streamDebug,$$streamDebug,0)
var DEBUG_PGP_CAMLINK $$IF(DEBUG_PGP_CAMLINK,$$DEBUG_PGP_CAMLINK,1)
var DEBUG_PGPCL_SER $$IF(DEBUG_PGPCL_SER,$$DEBUG_PGPCL_SER,2)
#var DEBUG_GENICAM $$IF(DEBUG_GENICAM,$$DEBUG_GENICAM,1)
var save_restoreLogMissingRecords $$IF(save_restoreLogMissingRecords,$$save_restoreLogMissingRecords,0)
#var dbLoadSuspendOnError $$IF(dbLoadSuspendOnError,$$dbLoadSuspendOnError,1)

# Setup the environment for the specified camera model
< db/$(MODEL).env

# =========================================================
# Configure an pgpCamlink driver for the specified camera model
# =========================================================
epicsEnvSet( "CAM_TYPE", "pgpCl" )
pgpCamlinkConfig(  "$(CAM_PORT)",     "$(PGP_BOARD)", "$(PGP_LANE)", "$(MODEL)", "$(CAMLINK_MODE)", $(IMAGE_XSIZE), $(IMAGE_YSIZE), 0 )
pgpClSerialConfig( "$(CAM_PORT).SER", "$(PGP_BOARD)", "$(PGP_LANE)", "$(MODEL)", "$(CAMLINK_MODE)" )

$$IF(GENICAM)
# Genicam
asynGenicamConfig( "$(CAM_PORT).SER", 0 )
$$ENDIF(GENICAM)

# Set asyn trace flags
asynSetTraceMask(   "$(CAM_PORT)",      0, $(CAM_TRACE_MASK) )
asynSetTraceIOMask( "$(CAM_PORT)",      0, $(CAM_TRACE_IO_MASK) )
asynSetTraceMask(   "$(CAM_PORT).SER",  0, $(SER_TRACE_MASK) )
asynSetTraceIOMask( "$(CAM_PORT).SER",  0, $(SER_TRACE_IO_MASK) )

$$IF(USE_TRACE_FILES)
asynSetTraceFile(	"$(CAM_PORT)",		0, "$(IOC_DATA)/$(IOC)/$(CAM_PORT).log" )
asynSetTraceFile(	"$(CAM_PORT).SER",	0, "$(IOC_DATA)/$(IOC)/$(CAM_PORT).SER.log" )
$$ENDIF(USE_TRACE_FILES)

# Configure and load standard pgpCamlink camera database
dbLoadRecords("db/pgpCamera.db", "CAM=$(CAM_PV),CAM_PORT=$(CAM_PORT),PGP=$(PGP_PV),PGP_LANE=$(PGP_LANE)" )
dbLoadRecords("db/pgpCam_hist.db",  "P=$(CAM_PV),R=:" )

# For camera serial asyn diagnostics
# (AreaDetector plugins each have their own AsynIO record)
dbLoadRecords("db/asynRecord.db",   "P=$(CAM_PV):SER,R=:AsynIO,PORT=$(CAM_PORT).SER,ADDR=0,IMAX=0,OMAX=0" )

# Load camera model specific db
dbLoadRecords("db/$(MODEL).db",     "P=$(CAM_PV),R=:,PORT=$(CAM_PORT),PGP=$(PGP_PV),PGP_LANE=$(PGP_LANE)" )

#- Provide some reasonable defaults for plugin macros
#- May be overridden by $(PLUGINS).cmd
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

$$LOOP(BLD)
#- TODO: Reconfigure BLD as Spectrometer plugin
# Configure and load BLD plugin
epicsEnvSet( "N",            "$$CALC{INDEX+1}" )
epicsEnvSet( "PLUGIN_SRC",   "CAM" )
< db/pluginBldSpectrometer.cmd
$$IF(HIST)
# Load history records
#- TODO: Fix me!  bld_hist.substitutions should become something
#- along the lines of
#- dbLoadRecords( "db/plugin$$(NAME)Hist.db 
#dbLoadRecords("db/bld_hist.db",     "P=$(CAM_PV),R=:" )
$$ENDIF(HIST)
$$ENDLOOP(BLD)

# Load records for various configuration sequences
dbLoadRecords("db/CamCannedSequences.db",	"CAM=$(CAM_PV),PGP=$(PGP_PV),CH=$(PGP_LANE)")

$$IF(NO_ST_CMD_DELAY)
$$ELSE(NO_ST_CMD_DELAY)
epicsThreadSleep $(ST_CMD_DELAYS)
$$ENDIF(NO_ST_CMD_DELAY)

# Load soft ioc related record instances
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/iocRelease.db",			"IOC=$(IOC_PV)" )
# Load devIocInfo for CAM
epicsEnvSet( "DEV_INFO", "DEV=$(CAM_PV),IOC=$(IOC_PV),IOCNAME=$(IOCNAME)" )
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),COM_TYPE=camLink,COM_PORT=Board $(PGP_BOARD) Lane $(PGP_LANE)" )
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
set_requestfile_path( "$(TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
#- pass0 autosave restore IS needed for cameras
set_pass0_restoreFile( "autoSettings.sav" )
#- pass1 for restoring event code
set_pass1_restoreFile( "autoPositions.sav" )

#
# iocInit: Initialize the IOC and start processing records
#
iocInit()

# iocInit done

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoPositions.req", "autosaveFields_pass1" )

# Start autosave backups
create_monitor_set( "autoSettings.req",  5,  "" )
create_monitor_set( "autoPositions.req",  5,  "" )

# Update archive file
system( "cp $(BUILD_TOP)/archive/$(IOC).archive $(IOC_DATA)/$(IOC)/archive/$(IOC).archive" ) 

$$IF(IOC_COMMON)
# All IOCs should dump some common info after initial startup.
< $(IOC_COMMON)/All/post_linux.cmd
$$ENDIF(IOC_COMMON)

$$LOOP(PLUGIN)
$$IF(BLD_SRC)
# Configure plugin specific BLD
epicsEnvSet( "BLD_IP",      "239.255.24.$$BLD_SRC" )
epicsEnvSet( "BLD_PORT",    "$$IF(PORT,$$PORT,10148)" )
epicsEnvSet( "BLD_MAX",     "$$IF(MAX,$$MAX,8980)" )    # 9000 MTU - 20 byte header
BldSetID( "$$IF(BLD_ID,$$BLD_ID,0)" )
BldConfigSend( "239.255.24.$$BLD_SRC", "$$IF(PORT,$$PORT,10148)", "$$IF(MAX,$$MAX,8980)", "$$IF(BLD_IF,$$BLD_IF,)" )

$$IF(BLD_AUTO_START)
# Autostart plugin specific BLD
BldStart()
$$ENDIF(BLD_AUTO_START)

BldIsStarted()
$$ENDIF(BLD_SRC)
$$ENDLOOP(PLUGIN)

# This is for the FEE Spectrometer
$$LOOP(BLD)
$$IF(BLD_SRC)
# Configure the BLD client
epicsEnvSet( "BLD_IP",      "239.255.24.$$BLD_SRC" )
epicsEnvSet( "BLD_PORT",    "$$IF(PORT,$$PORT,10148)" )
epicsEnvSet( "BLD_MAX",     "$$IF(MAX,$$MAX,8980)" )    # 9000 MTU - 20 byte header
BldSetID( "$$IF(BLD_ID,$$BLD_ID,0)" )
BldConfigSend( "239.255.24.$$BLD_SRC", "$$IF(PORT,$$PORT,10148)", "$$IF(MAX,$$MAX,8980)", "$$IF(BLD_IF,$$BLD_IF,)" )

$$IF(BLD_AUTO_START)
# Autostart plugin specific BLD
BldStart()
$$ENDIF(BLD_AUTO_START)

BldIsStarted()
$$ENDIF(BLD_SRC)
$$ENDLOOP(BLD)

#- TODO: Remove these dbpf calls if possible
# Enable callbacks
dbpf $(CAM_PV):ArrayCallbacks 1
dbpf $(CAM_PV):LAUNCH_EDM "$(BUILD_TOP)/iocBoot/$(IOCNAME)/edm-$(IOCNAME).cmd"

$$IF(AUTO_START)
# Final delay before auto-start image acquisition
# Long sleep to give rogue IOC time to boot on server startup
epicsThreadSleep 10
dbpf $(CAM_PV):Acquire $$AUTO_START
$$ENDIF(AUTO_START)
var DEBUG_PGP_CAMLINK $$IF(DEBUG_PGP_CAMLINK,$$DEBUG_PGP_CAMLINK,1)
var DEBUG_PGPCL_SER $$IF(DEBUG_PGPCL_SER,$$DEBUG_PGPCL_SER,2)

