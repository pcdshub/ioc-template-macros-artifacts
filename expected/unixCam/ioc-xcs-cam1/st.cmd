#!/reg/g/pcds/package/epics/3.14/ioc/common/unixCam/R3.6.2/bin/linux-x86_64/unixCam

epicsEnvSet("IOCNAME", "ioc-xcs-cam1")
epicsEnvSet("ENGINEER", "Michael Browne (mcbrowne)" )
epicsEnvSet("LOCATION", "IOC:XCS:CAM:01" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("STREAM_PROTOCOL_PATH", "db" )
epicsEnvSet("IOC_PV", "IOC:XCS:CAM:01")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/unixCam/R3.6.2")

< $(IOCTOP)/iocBoot/ioc/cameraDefs
< $(IOCTOP)/iocBoot/ioc/envPaths
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/package/epics/3.14/ioc/xcs/unixCam/R3.6.2/build")
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
dbLoadRecords( $(EVRDB_SLAC), "IOC=$(IOC_PV),EVR=XCS:R42:EVR:02,CARD=0,CAM0=XCS:USR:CVV:02,TU0=XCS:USR:CVV:02:TRIGGER_DELAY,IP9E=Enabled,CAM1=XCS:USR:CVV:01,TU1=XCS:USR:CVV:01:TRIGGER_DELAY,IP8E=Enabled" )


dbLoadRecords( "db/camdelay.db", "CAM=XCS:USR:CVV:02,EVR=XCS:R42:EVR:02,TRIGGER=9,BAUDRATE=$(CAMERA_BAUD_OPAL1K),DELAYFUDGE=$(CAMERA_FUDGE_OPAL1K)")
dbLoadRecords("db/evrDevInfo.db", "BASE=XCS:USR:CVV:02,EVR=XCS:R42:EVR:02,TRIG=9,NAME=XCS:USR:CVV:02")
dbLoadRecords( "db/camdelay.db", "CAM=XCS:USR:CVV:01,EVR=XCS:R42:EVR:02,TRIGGER=8,BAUDRATE=$(CAMERA_BAUD_PULNIX),DELAYFUDGE=$(CAMERA_FUDGE_PULNIX)")
dbLoadRecords("db/evrDevInfo.db", "BASE=XCS:USR:CVV:01,EVR=XCS:R42:EVR:02,TRIG=8,NAME=XCS:USR:CVV:01")

# Initialize the cameras
epicsCamInit( "XCS:USR:CVV:02", 0, 0, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_OPAL1K)", "XCS:R42:EVR:02:Triggers.J", "XCS:USR:CVV:02:TRIGGER_DELAY", "XCS:USR:CVV:02:SYNC" )
epicsCamInit( "XCS:USR:CVV:01", 0, 1, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_PULNIX)", "XCS:R42:EVR:02:Triggers.I", "XCS:USR:CVV:01:TRIGGER_DELAY", "XCS:USR:CVV:01:SYNC" )

# Enable sleep() calls as needed to diagnose startup errors
# epicsThreadSleep( 5.0 )

# Initialize EVR
ErConfigure( 0, 0, 0, 0, $(EVRID_SLAC) )

## Load EPICS records
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",	"IOC=$(IOC_PV)" )

dbLoadRecords( "db/fastlink.db", "CAM=XCS:USR:CVV:02,LNK1=XCS:USR:CVV:02:AVERAGER" )

dbLoadRecords( $(CAMERA_DB_OPAL1K),	 "CAM=XCS:USR:CVV:02,TS_EVENT=XCS:R42:EVR:02:Triggers.J,FAST_FLNK=XCS:USR:CVV:02:FASTLINK,BOARD=0,CHAN=0,TRIG=9,EVR=XCS:R42:EVR:02" )

dbLoadRecords( "db/fastlink.db", "CAM=XCS:USR:CVV:01,LNK1=XCS:USR:CVV:01:AVERAGER" )

dbLoadRecords( $(CAMERA_DB_PULNIX),	 "CAM=XCS:USR:CVV:01,TS_EVENT=XCS:R42:EVR:02:Triggers.I,FAST_FLNK=XCS:USR:CVV:01:FASTLINK,BOARD=0,CHAN=1,TRIG=8,EVR=XCS:R42:EVR:02" )




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
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV),EVR=XCS:R42:EVR:02" )


StartCams(1)

epicsThreadSleep( 2.0 )
dbpf XCS:USR:CVV:02:HWROI_ENABLE 1
dbpf XCS:USR:CVV:02:HWROI_SET.PROC 1
dbpf XCS:USR:CVV:01:HWROI_ENABLE 1
dbpf XCS:USR:CVV:01:HWROI_SET.PROC 1


# Run the post startup script
< /reg/d/iocCommon/All/post_linux.cmd
