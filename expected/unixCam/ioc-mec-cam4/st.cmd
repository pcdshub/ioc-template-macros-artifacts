#!/reg/g/pcds/package/epics/3.14/ioc/common/unixCam/R3.6.2/bin/linux-x86_64/unixCam

epicsEnvSet("IOCNAME", "ioc-mec-cam4")
epicsEnvSet("ENGINEER", "Ying Jin (yjin)" )
epicsEnvSet("LOCATION", "MEC:R64A:38" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("STREAM_PROTOCOL_PATH", "db" )
epicsEnvSet("IOC_PV", "IOC:MEC:CAM4")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/unixCam/R3.6.2")

< $(IOCTOP)/iocBoot/ioc/cameraDefs
< $(IOCTOP)/iocBoot/ioc/envPaths
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/package/epics/3.14/ioc/mec/unixCam/R3.6.2/build")
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
dbLoadRecords( $(EVRDB_PMC), "IOC=$(IOC_PV),EVR=MEC:CAM4:EVR,CARD=0,CAM0=MEC:XT2:CVV:01,TU0=MEC:XT2:CVV:01:TRIGGER_DELAY,IP0E=Enabled,CAM1=MEC:XT2:CVV:02,TU1=MEC:XT2:CVV:02:TRIGGER_DELAY,IP1E=Enabled" )


dbLoadRecords( "db/camdelay.db", "CAM=MEC:XT2:CVV:01,EVR=MEC:CAM4:EVR,TRIGGER=0,BAUDRATE=$(CAMERA_BAUD_PULNIX),DELAYFUDGE=$(CAMERA_FUDGE_PULNIX)")
dbLoadRecords("db/evrDevInfo.db", "BASE=MEC:XT2:CVV:01,EVR=MEC:CAM4:EVR,TRIG=0,NAME=MEC:XT2:CVV:01")
dbLoadRecords( "db/camdelay.db", "CAM=MEC:XT2:CVV:02,EVR=MEC:CAM4:EVR,TRIGGER=1,BAUDRATE=$(CAMERA_BAUD_PULNIX),DELAYFUDGE=$(CAMERA_FUDGE_PULNIX)")
dbLoadRecords("db/evrDevInfo.db", "BASE=MEC:XT2:CVV:02,EVR=MEC:CAM4:EVR,TRIG=1,NAME=MEC:XT2:CVV:02")

# Initialize the cameras
epicsCamInit( "MEC:XT2:CVV:01", 0, 0, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_PULNIX_T)", "MEC:CAM4:EVR:Triggers.A", "MEC:XT2:CVV:01:TRIGGER_DELAY", "MEC:XT2:CVV:01:SYNC" )
epicsCamInit( "MEC:XT2:CVV:02", 0, 1, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_PULNIX_T)", "MEC:CAM4:EVR:Triggers.B", "MEC:XT2:CVV:02:TRIGGER_DELAY", "MEC:XT2:CVV:02:SYNC" )

# Enable sleep() calls as needed to diagnose startup errors
# epicsThreadSleep( 5.0 )

# Initialize EVR
ErConfigure( 0, 0, 0, 0, $(EVRID_PMC) )

## Load EPICS records
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",	"IOC=$(IOC_PV)" )

dbLoadRecords( "db/fastlink.db", "CAM=MEC:XT2:CVV:01,LNK1=MEC:XT2:CVV:01:AVERAGER" )

dbLoadRecords( $(CAMERA_DB_PULNIX),	 "CAM=MEC:XT2:CVV:01,TS_EVENT=MEC:CAM4:EVR:Triggers.A,FAST_FLNK=MEC:XT2:CVV:01:FASTLINK,BOARD=0,CHAN=0,TRIG=0,EVR=MEC:CAM4:EVR" )

dbLoadRecords( "db/fastlink.db", "CAM=MEC:XT2:CVV:02,LNK1=MEC:XT2:CVV:02:AVERAGER" )

dbLoadRecords( $(CAMERA_DB_PULNIX),	 "CAM=MEC:XT2:CVV:02,TS_EVENT=MEC:CAM4:EVR:Triggers.B,FAST_FLNK=MEC:XT2:CVV:02:FASTLINK,BOARD=0,CHAN=1,TRIG=1,EVR=MEC:CAM4:EVR" )




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
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV),EVR=MEC:CAM4:EVR" )


StartCams(1)

epicsThreadSleep( 2.0 )
dbpf MEC:XT2:CVV:01:HWROI_ENABLE 1
dbpf MEC:XT2:CVV:01:HWROI_SET.PROC 1
dbpf MEC:XT2:CVV:02:HWROI_ENABLE 1
dbpf MEC:XT2:CVV:02:HWROI_SET.PROC 1


# Run the post startup script
< /reg/d/iocCommon/All/post_linux.cmd
