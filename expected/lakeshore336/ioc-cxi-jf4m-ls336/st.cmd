#!/reg/g/pcds/package/epics/3.14/ioc/common/lakeshore336/R1.0.1/bin/linux-x86_64/ls336

< envPaths
epicsEnvSet("IOCNAME", "ioc-cxi-jf4m-ls336" )
epicsEnvSet("ENGINEER", "Rajan Plumley (rajan-01)" )
epicsEnvSet("LOCATION", "CXI:IOC:TCT:LS336" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:CXI:JF4M:TCT")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/lakeshore336/R1.0.1")
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/cxi/lakeshore336/R1.0.0/build")
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
drvAsynIPPortConfigure( "CXI:JF4M:TCT", "lakeshore-cxi-01:7777 TCP", 0, 0, 0 )

asynSetTraceMask( "CXI:JF4M:TCT", 0, 0x1 ) # logging for normal operation

# Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/ls336.db", "TCT=CXI:JF4M:TCT,PORT=CXI:JF4M:TCT,DSCAN=1,CSCAN=5" )

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
