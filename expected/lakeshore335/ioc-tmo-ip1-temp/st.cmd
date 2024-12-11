#!/reg/g/pcds/epics/ioc/common/lakeshore335/R2.0.0/bin/rhel7-x86_64/lakeshore335

< envPaths
epicsEnvSet("IOCNAME", "ioc-tmo-ip1-temp" )
epicsEnvSet("ENGINEER", "Janez Govednik (janezg)" )
epicsEnvSet("LOCATION", "TMO:IP1:TCT:01" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:TMO:IP1:TCT:01")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/lakeshore335/R2.0.0")
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/tmo/lakeshore335/R1.0.0/build")
epicsEnvSet(streamDebug, 0)
## Add the path to the protocol files
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/lakeshore335.dbd")
lakeshore335_registerRecordDeviceDriver(pdbbase)

#------------------------------------------------------------------------------
# Asyn support

# Initialize IP Asyn support
drvAsynSerialPortConfigure("ls335-LSA29JT","/dev/ls335-LSA29JT",0,0,0)
asynSetOption("ls335-LSA29JT",0,"baud","57600")
asynSetOption("ls335-LSA29JT",0,"bits","7")
asynSetOption("ls335-LSA29JT",0,"parity","odd")


# Load record instances
dbLoadRecords( "db/iocSoft.db",             "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",  "IOC=$(IOC_PV)" )
dbLoadRecords("db/lakeshore335.db","TCT=TMO:IP1:TCT:01,PORT=ls335-LSA29JT,DSCAN=1,CSCAN=5")

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
