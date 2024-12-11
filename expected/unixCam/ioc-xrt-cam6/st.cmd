#!/reg/g/pcds/package/epics/3.14/ioc/common/unixCam/R3.6.7/bin/linux-x86_64/unixCam

epicsEnvSet("IOCNAME", "ioc-xrt-cam6")
epicsEnvSet("ENGINEER", "Michael Browne (mcbrowne)" )
epicsEnvSet("LOCATION", "IOC:XRT:P6:CAM" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("STREAM_PROTOCOL_PATH", "db" )
epicsEnvSet("IOC_PV", "IOC:XRT:P6:CAM")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/unixCam/R3.6.7")

< $(IOCTOP)/iocBoot/ioc/cameraDefs
< $(IOCTOP)/iocBoot/ioc/envPaths
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/xrt/unixCam/R3.6.7/build")
cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES", "10000000" )

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
dbLoadRecords( $(EVRDB_PMC), "IOC=$(IOC_PV),EVR=HXX:UM6:EVR,CARD=0,CAM0=HXX:UM6:CVP:01,TU0=HXX:UM6:CVP:01:TRIGGER_DELAY,IP0E=Enabled,CAM1=HXX:TST:MCB:01,TU1=HXX:TST:MCB:01:TRIGGER_DELAY,IP1E=Enabled" )


dbLoadRecords( "db/camdelay.db", "CAM=HXX:UM6:CVP:01,EVR=HXX:UM6:EVR,TRIGGER=0,BAUDRATE=$(CAMERA_BAUD_TM4200),DELAYFUDGE=$(CAMERA_FUDGE_TM4200)")
dbLoadRecords("db/evrDevInfo.db", "BASE=HXX:UM6:CVP:01,EVR=HXX:UM6:EVR,TRIG=0,NAME=HXX:UM6:CVP:01")
dbLoadRecords( "db/camdelay.db", "CAM=HXX:TST:MCB:01,EVR=HXX:UM6:EVR,TRIGGER=1,BAUDRATE=$(CAMERA_BAUD_TM4200),DELAYFUDGE=$(CAMERA_FUDGE_TM4200)")
dbLoadRecords("db/evrDevInfo.db", "BASE=HXX:TST:MCB:01,EVR=HXX:UM6:EVR,TRIG=1,NAME=HXX:TST:MCB:01")

# Initialize the cameras
epicsCamInit( "HXX:UM6:CVP:01", 0, 0, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_TM4200)", "HXX:UM6:EVR:Triggers.A", "HXX:UM6:CVP:01:TRIGGER_DELAY", "HXX:UM6:CVP:01:SYNC" )
epicsCamInit( "HXX:TST:MCB:01", 0, 1, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_TM4200)", "HXX:UM6:EVR:Triggers.B", "HXX:TST:MCB:01:TRIGGER_DELAY", "HXX:TST:MCB:01:SYNC" )

# Enable sleep() calls as needed to diagnose startup errors
# epicsThreadSleep( 5.0 )

# Initialize EVR
ErConfigure( 0, 0, 0, 0, $(EVRID_PMC) )

## Load EPICS records
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",	"IOC=$(IOC_PV)" )

dbLoadRecords( "db/fastlink.db", "CAM=HXX:UM6:CVP:01,LNK1=HXX:UM6:CVP:01:AVERAGER,LNK3=HXX:UM6:CVP:01:COMPRESSOR" )

dbLoadRecords( $(CAMERA_DB_TM4200),	 "CAM=HXX:UM6:CVP:01,TS_EVENT=HXX:UM6:EVR:Triggers.A,FAST_FLNK=HXX:UM6:CVP:01:FASTLINK,BOARD=0,CHAN=0,TRIG=0,EVR=HXX:UM6:EVR" )

dbLoadRecords( "db/compress.db"	"CAM=HXX:UM6:CVP:01,EVR=HXX:UM6:EVR,TRIG=0")
dbLoadRecords( "db/fastlink.db", "CAM=HXX:TST:MCB:01,LNK1=HXX:TST:MCB:01:AVERAGER,LNK3=HXX:TST:MCB:01:COMPRESSOR" )

dbLoadRecords( $(CAMERA_DB_TM4200),	 "CAM=HXX:TST:MCB:01,TS_EVENT=HXX:UM6:EVR:Triggers.B,FAST_FLNK=HXX:TST:MCB:01:FASTLINK,BOARD=0,CHAN=1,TRIG=1,EVR=HXX:UM6:EVR" )

dbLoadRecords( "db/compress.db"	"CAM=HXX:TST:MCB:01,EVR=HXX:UM6:EVR,TRIG=1")



# Setup autosave
set_savefile_path( "$(IOC_DATA)/ioc-xrt-cam6/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )

save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_pass0_restoreFile( "$(IOCNAME).sav" )
set_pass1_restoreFile( "$(IOCNAME).sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV),EVR=HXX:UM6:EVR" )


StartCams(1)

epicsThreadSleep( 2.0 )
dbpf HXX:UM6:CVP:01:HWROI_ENABLE 1
dbpf HXX:UM6:CVP:01:HWROI_SET.PROC 1
dbpf HXX:TST:MCB:01:HWROI_ENABLE 1
dbpf HXX:TST:MCB:01:HWROI_SET.PROC 1


# Run the post startup script
< /reg/d/iocCommon/All/post_linux.cmd
