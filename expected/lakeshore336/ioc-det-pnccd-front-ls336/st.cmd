#!/reg/g/pcds/epics/ioc/common/lakeshore336/R2.2.0/bin/linux-x86_64/ls336

< envPaths
epicsEnvSet("IOCNAME", "ioc-det-pnccd-front-ls336" )
epicsEnvSet("ENGINEER", "Ankush Mitra (mitra)" )
epicsEnvSet("LOCATION", "PNCCD:TCT:FRONT:LS336" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:PNCCD:TCT:FRONT")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/lakeshore336/R2.2.0")
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/det/lakeshore336/R1.1.0/build")
epicsEnvSet(streamDebug, 0)
## Add the path to the protocol files
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/ls336.dbd")
ls336_registerRecordDeviceDriver(pdbbase)

# Configure each device
drvAsynIPPortConfigure( "PNCCD:TCT:FRONT:01", "lakeshore01-det-pnccd01:7777 TCP", 0, 0, 0 )
drvAsynIPPortConfigure( "PNCCD:TCT:FRONT:02", "lakeshore02-det-pnccd01:7777 TCP", 0, 0, 0 )

asynSetTraceMask( "PNCCD:TCT:FRONT:01", 0, 0x1 ) # logging for normal operation
asynSetTraceMask( "PNCCD:TCT:FRONT:02", 0, 0x1 ) # logging for normal operation

# Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV)" )
dbLoadRecords( "db/ls336.db", "TCT=PNCCD:TCT:FRONT:01,PORT=PNCCD:TCT:FRONT:01,DSCAN=1,CSCAN=5" )
dbLoadRecords( "db/ls336.db", "TCT=PNCCD:TCT:FRONT:02,PORT=PNCCD:TCT:FRONT:02,DSCAN=1,CSCAN=5" )

# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOCNAME)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "$(IOCNAME).sav" )
set_pass1_restoreFile( "$(IOCNAME).sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV)" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
