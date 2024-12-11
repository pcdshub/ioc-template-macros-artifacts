#!/reg/g/pcds/package/epics/3.14/ioc/common/unixCam/R3.6.2/bin/linux-x86_64/unixCam

epicsEnvSet("IOCNAME", "ioc-mec-opal01")
epicsEnvSet("ENGINEER", "Dehong Zhang (dhzhang)" )
epicsEnvSet("LOCATION", "FEE:R03:IOC:27" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("STREAM_PROTOCOL_PATH", "db" )
epicsEnvSet("IOC_PV", "IOC:MEC:HXS:OPAL1K")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/unixCam/R3.6.2")

< $(IOCTOP)/iocBoot/ioc/cameraDefs
< $(IOCTOP)/iocBoot/ioc/envPaths
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/package/epics/3.14/ioc/mec/unixCam/R3.6.2/build")
cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES", "10000000" )

# Load EPICS database definition
dbLoadDatabase("dbd/unixCam.dbd",0,0)

# Register all support components
unixCam_registerRecordDeviceDriver(pdbbase)

# Initialize debug variables
var IMAGE_REDUCE_DEBUG 1
var EDT_UNIX_DEV_DEBUG 1
var DEBUG_HI_RES_TIME 0
ErDebugLevel( 0 )


## Load EPICS records
dbLoadRecords( $(EVRDB_SLAC), "IOC=$(IOC_PV),EVR=EVR:MEC:HXS,CARD=0,CAM0=MEC:OPAL1K:1,TU0=MEC:OPAL1K:1:TRIGGER_DELAY,IP0E=Enabled" )


dbLoadRecords( "db/camdelay.db", "CAM=MEC:OPAL1K:1,EVR=EVR:MEC:HXS,TRIGGER=0,BAUDRATE=$(CAMERA_BAUD_OPAL4K),DELAYFUDGE=$(CAMERA_FUDGE_OPAL4K)")
dbLoadRecords("db/evrDevInfo.db", "BASE=MEC:OPAL1K:1,EVR=EVR:MEC:HXS,TRIG=0,NAME=MEC:OPAL1K:1")

# Initialize the cameras
epicsCamInit( "MEC:OPAL1K:1", 0, 1, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_OPAL4K)", "EVR:MEC:HXS:Triggers.A", "MEC:OPAL1K:1:TRIGGER_DELAY", "MEC:OPAL1K:1:SYNC" )

# Enable sleep() calls as needed to diagnose startup errors
# epicsThreadSleep( 5.0 )

# Initialize EVR
ErConfigure( 0, 0, 0, 0, $(EVRID_SLAC) )

## Load EPICS records
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",	"IOC=$(IOC_PV)" )

dbLoadRecords( "db/fastlink.db", "CAM=MEC:OPAL1K:1,LNK1=MEC:OPAL1K:1:AVERAGER,LNK3=MEC:OPAL1K:1:COMPRESSOR,LNK4=MEC:OPAL1K:1:IMAGE:DoPrj" )

dbLoadRecords( $(CAMERA_DB_OPAL4K),	 "CAM=MEC:OPAL1K:1,TS_EVENT=EVR:MEC:HXS:Triggers.A,FAST_FLNK=MEC:OPAL1K:1:FASTLINK,BOARD=0,CHAN=1,TRIG=0,EVR=EVR:MEC:HXS" )

dbLoadRecords( "db/compress.db"	"CAM=MEC:OPAL1K:1,EVR=EVR:MEC:HXS,TRIG=0")
dbLoadRecords( "db/doprj.db"	"CAM=MEC:OPAL1K:1")



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
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV),EVR=EVR:MEC:HXS" )

dbpf MEC:OPAL1K:1:CMPX_COL.PROC 1
dbpf MEC:OPAL1K:1:CMPX_ROW.PROC 1


StartCams(1)

epicsThreadSleep( 2.0 )
dbpf MEC:OPAL1K:1:HWROI_ENABLE 1
dbpf MEC:OPAL1K:1:HWROI_SET.PROC 1


# Run the post startup script
< /reg/d/iocCommon/All/post_linux.cmd
