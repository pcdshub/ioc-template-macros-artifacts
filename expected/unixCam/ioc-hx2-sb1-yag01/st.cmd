#!/reg/g/pcds/package/epics/3.14/ioc/common/unixCam/R3.6.2/bin/linux-x86_64/unixCam

epicsEnvSet("IOCNAME", "ioc-hx2-sb1-yag01")
epicsEnvSet("ENGINEER", "Bruce Hill (bhill)" )
epicsEnvSet("LOCATION", "HX2:SB1:YAG:IOC" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("STREAM_PROTOCOL_PATH", "db" )
epicsEnvSet("IOC_PV", "HX2:SB1:YAG:IOC")
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
var EDT_UNIX_DEV_DEBUG 0
var DEBUG_HI_RES_TIME 0
ErDebugLevel( 0 )


## Load EPICS records
dbLoadRecords( $(EVRDB_PMC), "IOC=$(IOC_PV),EVR=HX2:EVR:YAG,CARD=0,CAM0=HX2:SB1:CVV:01,TU0=HX2:SB1:CVV:01:TRIGGER_DELAY,IP2E=Enabled" )


dbLoadRecords( "db/camdelay.db", "CAM=HX2:SB1:CVV:01,EVR=HX2:EVR:YAG,TRIGGER=2,BAUDRATE=$(CAMERA_BAUD_PULNIX),DELAYFUDGE=$(CAMERA_FUDGE_PULNIX)")
dbLoadRecords("db/evrDevInfo.db", "BASE=HX2:SB1:CVV:01,EVR=HX2:EVR:YAG,TRIG=2,NAME=HX2:SB1:CVV:01")

# Initialize the cameras
epicsCamInit( "HX2:SB1:CVV:01", 0, 0, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_PULNIX)", "HX2:EVR:YAG:Triggers.C", "HX2:SB1:CVV:01:TRIGGER_DELAY", "HX2:SB1:CVV:01:SYNC" )

# Enable sleep() calls as needed to diagnose startup errors
# epicsThreadSleep( 5.0 )

# Initialize EVR
ErConfigure( 0, 0, 0, 0, $(EVRID_PMC) )

## Load EPICS records
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",	"IOC=$(IOC_PV)" )

dbLoadRecords( "db/fastlink.db", "CAM=HX2:SB1:CVV:01,LNK1=HX2:SB1:CVV:01:AVERAGER" )

dbLoadRecords( $(CAMERA_DB_PULNIX),	 "CAM=HX2:SB1:CVV:01,TS_EVENT=HX2:EVR:YAG:Triggers.C,FAST_FLNK=HX2:SB1:CVV:01:FASTLINK,BOARD=0,CHAN=0,TRIG=2,EVR=HX2:EVR:YAG" )




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
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV),EVR=HX2:EVR:YAG" )


StartCams(1)

epicsThreadSleep( 2.0 )
dbpf HX2:SB1:CVV:01:HWROI_ENABLE 1
dbpf HX2:SB1:CVV:01:HWROI_SET.PROC 1


# Run the post startup script
< /reg/d/iocCommon/All/post_linux.cmd
