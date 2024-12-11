#!/cds/group/pcds/epics/ioc/common/labMax-TOP/R1.8.2/bin/linux-x86_64/labMax

epicsEnvSet("IOCNAME",    "ioc-mec-labMax" )
epicsEnvSet("ENGINEER",   "Christian Tsoi-A-Sue (ctsoi)")
epicsEnvSet("LOCATION",   "MEC:USR:LEM:01")
epicsEnvSet("IOCSH_PS1",  "$(IOCNAME)> ")
epicsEnvSet("IOC_PV",     "MEC:USR:LEM:01")
epicsEnvSet("IOCTOP",     "/cds/group/pcds/epics/ioc/common/labMax-TOP/R1.8.2")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/labMax-TopApp/srcProtocol")
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/mec/labMax-TOP/R1.0.1/build")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase("dbd/labMax.dbd")
labMax_registerRecordDeviceDriver(pdbbase)

## Set up IOC/hardware links -- LAN connection
# Coherent LabMax-TOP:
drvAsynIPPortConfigure( "bus0","moxa-mec-02:4016", 0, 0, 0 )
#asynSetTraceIOMask( "bus0", -1, 0x2 )
#asynSetTraceMask(   "bus0", -1, 0x9 )

## Load record instances
dbLoadRecords( "db/iocSoft.db",		  	"IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",	"IOC=$(IOC_PV)" )
dbLoadRecords( "db/labMax-Top.db",		"P=MEC:USR:LEM:01,PORT=bus0" )
dbLoadRecords( "db/asynRecord.db",		"P=MEC:USR:LEM:01,PORT=bus0,R=:asyn,ADDR=0,IMAX=0,OMAX=0" )

# Setup autosave
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )

# Restore the autosave settings
set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "$(IOC).sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOC).req", 5, "")

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
