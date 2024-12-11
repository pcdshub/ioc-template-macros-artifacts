#!/reg/g/pcds/package/epics/3.14/ioc/common/unixCam/R3.6.7/bin/linux-x86_64/unixCam

epicsEnvSet("IOCNAME", "ioc-xrt-cam3")
epicsEnvSet("ENGINEER", "Bruce Hill (bhill)" )
epicsEnvSet("LOCATION", "XRT:R38:IOC:42" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("STREAM_PROTOCOL_PATH", "db" )
epicsEnvSet("IOC_PV", "XRT:R38:IOC:42")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/unixCam/R3.6.7")

< $(IOCTOP)/iocBoot/ioc/cameraDefs
< $(IOCTOP)/iocBoot/ioc/envPaths
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/xrt/unixCam/R3.6.7/build")
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
dbLoadRecords( $(EVRDB_PMC), "IOC=$(IOC_PV),EVR=XRT:R38:EVR:42,CARD=0,CAM0=HFX:DG3:CVV:01,TU0=HFX:DG3:CVV:01:TRIGGER_DELAY,IP0E=Enabled,CAM1=XCS:DG3:CVV:02,TU1=XCS:DG3:CVV:02:TRIGGER_DELAY,IP1E=Enabled" )


dbLoadRecords( "db/camdelay.db", "CAM=HFX:DG3:CVV:01,EVR=XRT:R38:EVR:42,TRIGGER=0,BAUDRATE=$(CAMERA_BAUD_PULNIX),DELAYFUDGE=$(CAMERA_FUDGE_PULNIX)")
dbLoadRecords("db/evrDevInfo.db", "BASE=HFX:DG3:CVV:01,EVR=XRT:R38:EVR:42,TRIG=0,NAME=HFX:DG3:CVV:01")
dbLoadRecords( "db/camdelay.db", "CAM=XCS:DG3:CVV:02,EVR=XRT:R38:EVR:42,TRIGGER=1,BAUDRATE=$(CAMERA_BAUD_PULNIX),DELAYFUDGE=$(CAMERA_FUDGE_PULNIX)")
dbLoadRecords("db/evrDevInfo.db", "BASE=XCS:DG3:CVV:02,EVR=XRT:R38:EVR:42,TRIG=1,NAME=XCS:DG3:CVV:02")

# Initialize the cameras
epicsCamInit( "HFX:DG3:CVV:01", 0, 0, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_PULNIX)", "XRT:R38:EVR:42:Triggers.A", "HFX:DG3:CVV:01:TRIGGER_DELAY", "HFX:DG3:CVV:01:SYNC" )
epicsCamInit( "XCS:DG3:CVV:02", 0, 1, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_PULNIX)", "XRT:R38:EVR:42:Triggers.B", "XCS:DG3:CVV:02:TRIGGER_DELAY", "XCS:DG3:CVV:02:SYNC" )

# Enable sleep() calls as needed to diagnose startup errors
# epicsThreadSleep( 5.0 )

# Initialize EVR
ErConfigure( 0, 0, 0, 0, $(EVRID_PMC) )

## Load EPICS records
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",	"IOC=$(IOC_PV)" )

dbLoadRecords( "db/fastlink.db", "CAM=HFX:DG3:CVV:01,LNK1=HFX:DG3:CVV:01:AVERAGER" )

dbLoadRecords( $(CAMERA_DB_PULNIX),	 "CAM=HFX:DG3:CVV:01,TS_EVENT=XRT:R38:EVR:42:Triggers.A,FAST_FLNK=HFX:DG3:CVV:01:FASTLINK,BOARD=0,CHAN=0,TRIG=0,EVR=XRT:R38:EVR:42" )

dbLoadRecords( "db/fastlink.db", "CAM=XCS:DG3:CVV:02,LNK1=XCS:DG3:CVV:02:AVERAGER" )

dbLoadRecords( $(CAMERA_DB_PULNIX),	 "CAM=XCS:DG3:CVV:02,TS_EVENT=XRT:R38:EVR:42:Triggers.B,FAST_FLNK=XCS:DG3:CVV:02:FASTLINK,BOARD=0,CHAN=1,TRIG=1,EVR=XRT:R38:EVR:42" )




# Setup autosave
set_savefile_path( "$(IOC_DATA)/ioc-xrt-cam3/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )

save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_pass0_restoreFile( "$(IOCNAME).sav" )
set_pass1_restoreFile( "$(IOCNAME).sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV),EVR=XRT:R38:EVR:42" )


StartCams(1)

epicsThreadSleep( 2.0 )
dbpf HFX:DG3:CVV:01:HWROI_ENABLE 1
dbpf HFX:DG3:CVV:01:HWROI_SET.PROC 1
dbpf XCS:DG3:CVV:02:HWROI_ENABLE 1
dbpf XCS:DG3:CVV:02:HWROI_SET.PROC 1


# Run the post startup script
< /reg/d/iocCommon/All/post_linux.cmd
