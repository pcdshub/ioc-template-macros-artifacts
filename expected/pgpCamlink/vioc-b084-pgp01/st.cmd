#!/reg/g/pcds/epics/ioc/common/pgpCamlink/R1.7.1/bin/linuxRT-x86_64/pgpCl


epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/common/pgpCamlink/R1.7.1/children/build" )
< envPaths
epicsEnvSet( "IOCNAME",      "vioc-b084-pgp01" )
epicsEnvSet( "ENGINEER",     "Bruce Hill (bhill)" )
epicsEnvSet( "LOCATION",     "Bldg 84, Rm lab2, DEV" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "IOC:B84:LAB2:O1000" )
epicsEnvSet( "IOCTOP",       "/reg/g/pcds/epics/ioc/common/pgpCamlink/R1.7.1" )
epicsEnvSet( "EPICS_PVA_AUTO_ADDR_LIST",         "TRUE" )
epicsEnvSet( "EPICS_PVAS_AUTO_BEACON_ADDR_LIST", "TRUE" )

# Set Max array size
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "20000000" )

# Specify PGP_PV
epicsEnvSet( "PGP_PV",       "CAMR:B84:LAB2:PGP:01" )

# Specify PGP_PORT
epicsEnvSet( "PGP_PORT",     "PGP" )
epicsEnvSet( "PGP_BOARD",    "0" )

#
#< pgpCl.cmd
#
cd( "$(IOCTOP)" )

# Specify camera env variables
epicsEnvSet( "CAM_PV",       "CAMR:B84:LAB2:O1000" )
epicsEnvSet( "CAM_PORT",     "CAM" )
epicsEnvSet( "MODEL",        "opal1000m_12" )
epicsEnvSet( "HTTP_PORT",    "8002" )
epicsEnvSet( "N_AD_BUFFERS", "0" )
# Default pgpCamlinkDriver settings
epicsEnvSet( "PGP_LANE",     		 "0" )
epicsEnvSet( "CAMLINK_MODE",         "Base" )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "db" )

# Diagnostic settings
epicsEnvSet( "ST_CMD_DELAYS",		"1" )
epicsEnvSet( "CAM_TRACE_MASK",		"1" )
epicsEnvSet( "CAM_TRACE_IO_MASK",	"1" )
epicsEnvSet( "SER_TRACE_MASK",	    "1" )
epicsEnvSet( "SER_TRACE_IO_MASK",	"1" )

# Register support components
dbLoadDatabase( "dbd/pgpCl.dbd" )
pgpCl_registerRecordDeviceDriver(pdbbase)


# Set iocsh debug variables
var streamDebug 0
var streamDebugColored 0
var DEBUG_PGP_CAMLINK 2
var DEBUG_PGPCL_SER 1
#var DEBUG_GENICAM 1
var save_restoreLogMissingRecords 0
#var dbLoadSuspendOnError 1

# Setup the environment for the specified camera model
< db/$(MODEL).env


# =========================================================
# Configure an pgpCamlink driver for the specified camera model
# =========================================================
epicsEnvSet( "CAM_TYPE", "pgpCl" )
pgpCamlinkConfig(  "$(CAM_PORT)",     "$(PGP_BOARD)", "$(PGP_LANE)", "$(MODEL)", "$(CAMLINK_MODE)", $(IMAGE_XSIZE), $(IMAGE_YSIZE), 0 )
pgpClSerialConfig( "$(CAM_PORT).SER", "$(PGP_BOARD)", "$(PGP_LANE)", "$(MODEL)", "$(CAMLINK_MODE)" )


# Set asyn trace flags
asynSetTraceMask(   "$(CAM_PORT)",      0, $(CAM_TRACE_MASK) )
asynSetTraceIOMask( "$(CAM_PORT)",      0, $(CAM_TRACE_IO_MASK) )
asynSetTraceMask(   "$(CAM_PORT).SER",  0, $(SER_TRACE_MASK) )
asynSetTraceIOMask( "$(CAM_PORT).SER",  0, $(SER_TRACE_IO_MASK) )


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


# Load records for various configuration sequences
dbLoadRecords("db/CamCannedSequences.db",	"CAM=$(CAM_PV),PGP=$(PGP_PV),CH=$(PGP_LANE)")

epicsThreadSleep $(ST_CMD_DELAYS)

# Load soft ioc related record instances
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/iocRelease.db",			"IOC=$(IOC_PV)" )


# Load devIocInfo for CAM
epicsEnvSet( "DEV_INFO", "DEV=$(CAM_PV),IOC=$(IOC_PV),IOCNAME=$(IOCNAME)" )
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),COM_TYPE=camLink,COM_PORT=Board $(PGP_BOARD) Lane $(PGP_LANE)" )
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),POWER=ACSW:B084:NW04:8POWEROFF" )
dbLoadRecords( "db/devIocInfo.db",			"$(DEV_INFO)" )

# Setup autosave
dbLoadRecords( "db/save_restoreStatus.db",	"P=$(IOC_PV):SR:" )
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(BUILD_TOP)/autosave" )
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



# This is for the FEE Spectrometer

#- TODO: Remove these dbpf calls if possible

# Enable CAM callbacks
dbpf $(CAM_PV):ArrayCallbacks 1
dbpf $(CAM_PV):LAUNCH_EDM "$(BUILD_TOP)/iocBoot/$(IOCNAME)/edm-$(IOCNAME).cmd"

# Final delay before auto-start image acquisition
# Long sleep to give rogue IOC time to boot on server startup
epicsThreadSleep 10
dbpf $(CAM_PV):Acquire 0
var DEBUG_PGP_CAMLINK 2
var DEBUG_PGPCL_SER 1

