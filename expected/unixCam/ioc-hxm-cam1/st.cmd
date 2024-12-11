#!/reg/g/pcds/package/epics/3.14/ioc/common/unixCam/R3.6.7/bin/linux-x86_64/unixCam

epicsEnvSet("IOCNAME", "ioc-hxm-cam1")
epicsEnvSet("ENGINEER", "Richard Dabney (rdabney)" )
epicsEnvSet("LOCATION", "XRT:R04:IOC:33" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("STREAM_PROTOCOL_PATH", "db" )
epicsEnvSet("IOC_PV", "XRT:R04:IOC:33")
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
dbLoadRecords( $(EVRDB_PMC), "IOC=$(IOC_PV),EVR=XRT:R04:EVR:33,CARD=0,CAM0=HXX:HXM:CVV:01,TU0=HXX:HXM:CVV:01:TRIGGER_DELAY,IP1E=Enabled" )


dbLoadRecords( "db/camdelay.db", "CAM=HXX:HXM:CVV:01,EVR=XRT:R04:EVR:33,TRIGGER=1,BAUDRATE=$(CAMERA_BAUD_OPAL2K),DELAYFUDGE=$(CAMERA_FUDGE_OPAL2K)")
dbLoadRecords("db/evrDevInfo.db", "BASE=HXX:HXM:CVV:01,EVR=XRT:R04:EVR:33,TRIG=1,NAME=HXX:HXM:CVV:01")

# Initialize the cameras
epicsCamInit( "HXX:HXM:CVV:01", 0, 1, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_OPAL2K)", "XRT:R04:EVR:33:Triggers.B", "HXX:HXM:CVV:01:TRIGGER_DELAY", "HXX:HXM:CVV:01:SYNC" )

# Enable sleep() calls as needed to diagnose startup errors
# epicsThreadSleep( 5.0 )

# Initialize EVR
ErConfigure( 0, 0, 0, 0, $(EVRID_PMC) )

## Load EPICS records
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",	"IOC=$(IOC_PV)" )

dbLoadRecords( "db/fastlink.db", "CAM=HXX:HXM:CVV:01,LNK1=HXX:HXM:CVV:01:AVERAGER" )

dbLoadRecords( $(CAMERA_DB_OPAL2K),	 "CAM=HXX:HXM:CVV:01,TS_EVENT=XRT:R04:EVR:33:Triggers.B,FAST_FLNK=HXX:HXM:CVV:01:FASTLINK,BOARD=0,CHAN=1,TRIG=1,EVR=XRT:R04:EVR:33" )




# Setup autosave
set_savefile_path( "$(IOC_DATA)/ioc-hxm-cam1/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )

save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_pass0_restoreFile( "$(IOCNAME).sav" )
set_pass1_restoreFile( "$(IOCNAME).sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV),EVR=XRT:R04:EVR:33" )


StartCams(1)

epicsThreadSleep( 2.0 )
dbpf HXX:HXM:CVV:01:HWROI_ENABLE 1
dbpf HXX:HXM:CVV:01:HWROI_SET.PROC 1


# Run the post startup script
< /reg/d/iocCommon/All/post_linux.cmd
