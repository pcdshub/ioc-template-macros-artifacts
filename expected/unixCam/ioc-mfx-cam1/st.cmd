#!/reg/g/pcds/package/epics/3.14/ioc/common/unixCam/R3.6.2/bin/linux-x86_64/unixCam

epicsEnvSet("IOCNAME", "ioc-mfx-cam1")
epicsEnvSet("ENGINEER", "Teddy Rendahl (trendahl)" )
epicsEnvSet("LOCATION", "MFX:REC:IOC:01" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("STREAM_PROTOCOL_PATH", "db" )
epicsEnvSet("IOC_PV", "MFX:REC:IOC:01")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/unixCam/R3.6.2")

< $(IOCTOP)/iocBoot/ioc/cameraDefs
< $(IOCTOP)/iocBoot/ioc/envPaths
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/package/epics/3.14/ioc/mfx/unixCam/R0.0.2/build")
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
dbLoadRecords( $(EVRDB_PMC), "IOC=$(IOC_PV),EVR=MFX:REC:EVR:01,CARD=0,CAM0=MFX:DG1:CVV:01,TU0=MFX:DG1:CVV:01:TRIGGER_DELAY,IP0E=Enabled,CAM1=MFX:DG2:CVV:01,TU1=MFX:DG2:CVV:01:TRIGGER_DELAY,IP1E=Enabled" )


dbLoadRecords( "db/camdelay.db", "CAM=MFX:DG1:CVV:01,EVR=MFX:REC:EVR:01,TRIGGER=0,BAUDRATE=$(CAMERA_BAUD_PULNIX),DELAYFUDGE=$(CAMERA_FUDGE_PULNIX)")
dbLoadRecords("db/evrDevInfo.db", "BASE=MFX:DG1:CVV:01,EVR=MFX:REC:EVR:01,TRIG=0,NAME=MFX:DG1:CVV:01")
dbLoadRecords( "db/camdelay.db", "CAM=MFX:DG2:CVV:01,EVR=MFX:REC:EVR:01,TRIGGER=1,BAUDRATE=$(CAMERA_BAUD_PULNIX),DELAYFUDGE=$(CAMERA_FUDGE_PULNIX)")
dbLoadRecords("db/evrDevInfo.db", "BASE=MFX:DG2:CVV:01,EVR=MFX:REC:EVR:01,TRIG=1,NAME=MFX:DG2:CVV:01")

# Initialize the cameras
epicsCamInit( "MFX:DG1:CVV:01", 0, 0, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_PULNIX)", "MFX:REC:EVR:01:Triggers.A", "MFX:DG1:CVV:01:TRIGGER_DELAY", "MFX:DG1:CVV:01:SYNC" )
epicsCamInit( "MFX:DG2:CVV:01", 0, 1, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_PULNIX)", "MFX:REC:EVR:01:Triggers.B", "MFX:DG2:CVV:01:TRIGGER_DELAY", "MFX:DG2:CVV:01:SYNC" )

# Enable sleep() calls as needed to diagnose startup errors
# epicsThreadSleep( 5.0 )

# Initialize EVR
ErConfigure( 0, 0, 0, 0, $(EVRID_PMC) )

## Load EPICS records
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",	"IOC=$(IOC_PV)" )

dbLoadRecords( "db/fastlink.db", "CAM=MFX:DG1:CVV:01,LNK1=MFX:DG1:CVV:01:AVERAGER" )

dbLoadRecords( $(CAMERA_DB_PULNIX),	 "CAM=MFX:DG1:CVV:01,TS_EVENT=MFX:REC:EVR:01:Triggers.A,FAST_FLNK=MFX:DG1:CVV:01:FASTLINK,BOARD=0,CHAN=0,TRIG=0,EVR=MFX:REC:EVR:01" )

dbLoadRecords( "db/fastlink.db", "CAM=MFX:DG2:CVV:01,LNK1=MFX:DG2:CVV:01:AVERAGER" )

dbLoadRecords( $(CAMERA_DB_PULNIX),	 "CAM=MFX:DG2:CVV:01,TS_EVENT=MFX:REC:EVR:01:Triggers.B,FAST_FLNK=MFX:DG2:CVV:01:FASTLINK,BOARD=0,CHAN=1,TRIG=1,EVR=MFX:REC:EVR:01" )




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
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV),EVR=MFX:REC:EVR:01" )


StartCams(1)

epicsThreadSleep( 2.0 )
dbpf MFX:DG1:CVV:01:HWROI_ENABLE 1
dbpf MFX:DG1:CVV:01:HWROI_SET.PROC 1
dbpf MFX:DG2:CVV:01:HWROI_ENABLE 1
dbpf MFX:DG2:CVV:01:HWROI_SET.PROC 1


# Run the post startup script
< /reg/d/iocCommon/All/post_linux.cmd
