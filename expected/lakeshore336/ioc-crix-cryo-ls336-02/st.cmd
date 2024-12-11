#!/reg/g/pcds/epics/ioc/common/lakeshore336/R2.2.3/bin/rhel7-x86_64/ls336

< envPaths
epicsEnvSet("IOCNAME", "ioc-crix-cryo-ls336-02" )
epicsEnvSet("ENGINEER", "Will Wright (wwright8)" )
epicsEnvSet("LOCATION", "CRIX:IOC:CRYO:LS336" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:CRIX:CRYO:TCT:02")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/lakeshore336/R2.2.3")
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/rix/lakeshore336/R1.0.2/build")
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
drvAsynIPPortConfigure( "CRIX:CRYO:TCT:02", "lakeshore-crix-cryo-02:7777 TCP", 0, 0, 0 )

asynSetTraceMask( "CRIX:CRYO:TCT:02", 0, 0x1 ) # logging for normal operation

# Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV)" )
dbLoadRecords( "db/ls336.db", "TCT=CRIX:CRYO:TCT:02,PORT=CRIX:CRYO:TCT:02,DSCAN=1,CSCAN=5" )

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
