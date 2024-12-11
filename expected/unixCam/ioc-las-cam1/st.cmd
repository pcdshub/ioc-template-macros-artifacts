#!/reg/g/pcds/package/epics/3.14/ioc/common/unixCam/R3.6.2/bin/linux-x86_64/unixCam

epicsEnvSet("IOCNAME", "ioc-las-cam1")
epicsEnvSet("ENGINEER", "Pavel Stoffel (pstoffel)" )
epicsEnvSet("LOCATION", "LAS:R54:IOC:21" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("STREAM_PROTOCOL_PATH", "db" )
epicsEnvSet("IOC_PV", "LAS:R54:IOC:21")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/unixCam/R3.6.2")

< $(IOCTOP)/iocBoot/ioc/cameraDefs
< $(IOCTOP)/iocBoot/ioc/envPaths
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/package/epics/3.14/ioc/las/unixCam/R3.6.2/build")
cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES", "8000000" )

# Load EPICS database definition
dbLoadDatabase("dbd/unixCam.dbd",0,0)

# Register all support components
unixCam_registerRecordDeviceDriver(pdbbase)

# Initialize debug variables
var IMAGE_REDUCE_DEBUG 0
var EDT_UNIX_DEV_DEBUG 0
var DEBUG_HI_RES_TIME 0
ErDebugLevel( 0 )


## Load EPICS records
dbLoadRecords( $(EVRDB_PMC), "IOC=$(IOC_PV),EVR=LAS:R54:EVR:21,CARD=0,CAM0=LAS:EXP:CVV:01,CAM1=LAS:EXP:CVV:02,CAM2=LAS:EXP:CVV:03,CAM3=LAS:EXP:CVV:04" )



# Initialize the cameras
epicsCamInit( "LAS:EXP:CVV:01", 0, 0, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_UP685)")
epicsCamInit( "LAS:EXP:CVV:02", 0, 1, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_UP685)")
epicsCamInit( "LAS:EXP:CVV:03", 1, 0, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_UP900F)")
epicsCamInit( "LAS:EXP:CVV:04", 1, 1, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_PULNIX)")

# Enable sleep() calls as needed to diagnose startup errors
# epicsThreadSleep( 5.0 )

# Initialize EVR
ErConfigure( 0, 0, 0, 0, $(EVRID_PMC) )

## Load EPICS records
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",	"IOC=$(IOC_PV)" )

dbLoadRecords( $(CAMERA_DB_UP685),      "CAM=LAS:EXP:CVV:01,TS_EVENT=140" )
dbLoadRecords( $(CAMERA_DB_UP685),      "CAM=LAS:EXP:CVV:02,TS_EVENT=140" )
dbLoadRecords( $(CAMERA_DB_UP900F),      "CAM=LAS:EXP:CVV:03,TS_EVENT=140" )
dbLoadRecords( $(CAMERA_DB_PULNIX),      "CAM=LAS:EXP:CVV:04,TS_EVENT=140" )



# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )

save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_pass0_restoreFile( "$(IOCNAME).sav" )
set_pass1_restoreFile( "$(IOCNAME).sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV),EVR=LAS:R54:EVR:21" )


StartCams(1)

epicsThreadSleep( 2.0 )
dbpf LAS:EXP:CVV:01:HWROI_ENABLE 1
dbpf LAS:EXP:CVV:01:HWROI_SET.PROC 1
dbpf LAS:EXP:CVV:02:HWROI_ENABLE 1
dbpf LAS:EXP:CVV:02:HWROI_SET.PROC 1
dbpf LAS:EXP:CVV:03:HWROI_ENABLE 1
dbpf LAS:EXP:CVV:03:HWROI_SET.PROC 1
dbpf LAS:EXP:CVV:04:HWROI_ENABLE 1
dbpf LAS:EXP:CVV:04:HWROI_SET.PROC 1


# Run the post startup script
< /reg/d/iocCommon/All/post_linux.cmd
