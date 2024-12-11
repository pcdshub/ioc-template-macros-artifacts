#!/reg/g/pcds/package/epics/3.14/ioc/common/unixCam/R3.6.2/bin/linux-x86_64/unixCam

epicsEnvSet("IOCNAME", "ioc-xpp-opal1k1")
epicsEnvSet("ENGINEER", "Bruce Hill (bhill)" )
epicsEnvSet("LOCATION", "XPP:R30:IOC:27" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("STREAM_PROTOCOL_PATH", "db" )
epicsEnvSet("IOC_PV", "XPP:R30:IOC:27")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/unixCam/R3.6.2")

< $(IOCTOP)/iocBoot/ioc/cameraDefs
< $(IOCTOP)/iocBoot/ioc/envPaths
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/package/epics/3.14/ioc/xpp/unixCam/R3.6.3/build")
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
var EDT_UNIX_DEV_DEBUG 2
var DEBUG_HI_RES_TIME 0
ErDebugLevel( 0 )


## Load EPICS records
dbLoadRecords( $(EVRDB_SLAC), "IOC=$(IOC_PV),EVR=XPP:R30:EVR:27,CARD=0,CAM0=XPP:OPAL1K:1,TU0=XPP:OPAL1K:1:TRIGGER_DELAY,IP0E=Enabled,CAM1=XPP:OPAL1K:2,TU1=XPP:OPAL1K:2:TRIGGER_DELAY,IP1E=Enabled,CAM2=XPP:PULNIX:1,TU2=XPP:PULNIX:1:TRIGGER_DELAY,IP3E=Enabled,CAM3=XPP:PULNIX:2,TU3=XPP:PULNIX:2:TRIGGER_DELAY,IP4E=Enabled" )


dbLoadRecords( "db/camdelay.db", "CAM=XPP:OPAL1K:1,EVR=XPP:R30:EVR:27,TRIGGER=0,BAUDRATE=$(CAMERA_BAUD_OPAL1K),DELAYFUDGE=$(CAMERA_FUDGE_OPAL1K)")
dbLoadRecords("db/evrDevInfo.db", "BASE=XPP:OPAL1K:1,EVR=XPP:R30:EVR:27,TRIG=0,NAME=XPP:OPAL1K:1")
dbLoadRecords( "db/camdelay.db", "CAM=XPP:OPAL1K:2,EVR=XPP:R30:EVR:27,TRIGGER=1,BAUDRATE=$(CAMERA_BAUD_OPAL1K),DELAYFUDGE=$(CAMERA_FUDGE_OPAL1K)")
dbLoadRecords("db/evrDevInfo.db", "BASE=XPP:OPAL1K:2,EVR=XPP:R30:EVR:27,TRIG=1,NAME=XPP:OPAL1K:2")
dbLoadRecords( "db/camdelay.db", "CAM=XPP:PULNIX:1,EVR=XPP:R30:EVR:27,TRIGGER=3,BAUDRATE=$(CAMERA_BAUD_PULNIX),DELAYFUDGE=$(CAMERA_FUDGE_PULNIX)")
dbLoadRecords("db/evrDevInfo.db", "BASE=XPP:PULNIX:1,EVR=XPP:R30:EVR:27,TRIG=3,NAME=XPP:PULNIX:1")
dbLoadRecords( "db/camdelay.db", "CAM=XPP:PULNIX:2,EVR=XPP:R30:EVR:27,TRIGGER=4,BAUDRATE=$(CAMERA_BAUD_PULNIX),DELAYFUDGE=$(CAMERA_FUDGE_PULNIX)")
dbLoadRecords("db/evrDevInfo.db", "BASE=XPP:PULNIX:2,EVR=XPP:R30:EVR:27,TRIG=4,NAME=XPP:PULNIX:2")

# Initialize the cameras
epicsCamInit( "XPP:OPAL1K:1", 0, 0, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_OPAL1K)", "XPP:R30:EVR:27:Triggers.A", "XPP:OPAL1K:1:TRIGGER_DELAY", "XPP:OPAL1K:1:SYNC" )
epicsCamInit( "XPP:OPAL1K:2", 0, 1, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_OPAL1K)", "XPP:R30:EVR:27:Triggers.B", "XPP:OPAL1K:2:TRIGGER_DELAY", "XPP:OPAL1K:2:SYNC" )
epicsCamInit( "XPP:PULNIX:1", 1, 0, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_PULNIX)", "XPP:R30:EVR:27:Triggers.D", "XPP:PULNIX:1:TRIGGER_DELAY", "XPP:PULNIX:1:SYNC" )
epicsCamInit( "XPP:PULNIX:2", 1, 1, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_PULNIX)", "XPP:R30:EVR:27:Triggers.E", "XPP:PULNIX:2:TRIGGER_DELAY", "XPP:PULNIX:2:SYNC" )

# Enable sleep() calls as needed to diagnose startup errors
# epicsThreadSleep( 5.0 )

# Initialize EVR
ErConfigure( 0, 0, 0, 0, $(EVRID_SLAC) )

## Load EPICS records
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",	"IOC=$(IOC_PV)" )

dbLoadRecords( "db/fastlink.db", "CAM=XPP:OPAL1K:1,LNK1=XPP:OPAL1K:1:AVERAGER" )

dbLoadRecords( $(CAMERA_DB_OPAL1K),	 "CAM=XPP:OPAL1K:1,TS_EVENT=XPP:R30:EVR:27:Triggers.A,FAST_FLNK=XPP:OPAL1K:1:FASTLINK,BOARD=0,CHAN=0,TRIG=0,EVR=XPP:R30:EVR:27" )

dbLoadRecords( "db/fastlink.db", "CAM=XPP:OPAL1K:2,LNK1=XPP:OPAL1K:2:AVERAGER" )

dbLoadRecords( $(CAMERA_DB_OPAL1K),	 "CAM=XPP:OPAL1K:2,TS_EVENT=XPP:R30:EVR:27:Triggers.B,FAST_FLNK=XPP:OPAL1K:2:FASTLINK,BOARD=0,CHAN=1,TRIG=1,EVR=XPP:R30:EVR:27" )

dbLoadRecords( "db/fastlink.db", "CAM=XPP:PULNIX:1,LNK1=XPP:PULNIX:1:AVERAGER" )

dbLoadRecords( $(CAMERA_DB_PULNIX),	 "CAM=XPP:PULNIX:1,TS_EVENT=XPP:R30:EVR:27:Triggers.D,FAST_FLNK=XPP:PULNIX:1:FASTLINK,BOARD=1,CHAN=0,TRIG=3,EVR=XPP:R30:EVR:27" )

dbLoadRecords( "db/fastlink.db", "CAM=XPP:PULNIX:2,LNK1=XPP:PULNIX:2:AVERAGER" )

dbLoadRecords( $(CAMERA_DB_PULNIX),	 "CAM=XPP:PULNIX:2,TS_EVENT=XPP:R30:EVR:27:Triggers.E,FAST_FLNK=XPP:PULNIX:2:FASTLINK,BOARD=1,CHAN=1,TRIG=4,EVR=XPP:R30:EVR:27" )




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
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV),EVR=XPP:R30:EVR:27" )


StartCams(1)

epicsThreadSleep( 2.0 )
dbpf XPP:OPAL1K:1:HWROI_ENABLE 1
dbpf XPP:OPAL1K:1:HWROI_SET.PROC 1
dbpf XPP:OPAL1K:2:HWROI_ENABLE 1
dbpf XPP:OPAL1K:2:HWROI_SET.PROC 1
dbpf XPP:PULNIX:1:HWROI_ENABLE 1
dbpf XPP:PULNIX:1:HWROI_SET.PROC 1
dbpf XPP:PULNIX:2:HWROI_ENABLE 1
dbpf XPP:PULNIX:2:HWROI_SET.PROC 1


# Run the post startup script
< /reg/d/iocCommon/All/post_linux.cmd
