#!/reg/g/pcds/epics/ioc/common/detector-ctrl/R3.3.0/bin/rhel7-x86_64/detector

< envPaths
epicsEnvSet("IOCNAME",   "ioc-xpp-det")
epicsEnvSet("ENGINEER",  "Silke Nelson (snelson)")
epicsEnvSet("LOCATION",  "XPP:R35:IOC:39:DET")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> ")
epicsEnvSet("IOC_PV",    "XPP:IOC:DET")
epicsEnvSet("IOCTOP",    "/reg/g/pcds/epics/ioc/common/detector-ctrl/R3.3.0")
epicsEnvSet("TOP",       "/reg/g/pcds/epics/ioc/common/detector-ctrl/R3.3.0/children/build")
## Env variables for the big cspad temperature handling modes
epicsEnvSet("DETDB_NONE",  "db/detector-null-temp.db")
epicsEnvSet("DETDB_DAQ",   "db/detector-DAQ-temp.db")
epicsEnvSet("DETDB_EPICS", "db/detector.db")
## Add the path to the protocol files
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase("dbd/detector.dbd")
detector_registerRecordDeviceDriver(pdbbase)

# Asyn support

## Asyn record support
dbLoadRecords("$(ASYN)/db/asynRecord.db","P=XPP:DET:TE-TECH1,R=:asyn,PORT=bus0,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure ("bus0","172.21.38.24:2009", 0, 0, 0)
dbLoadRecords("$(ASYN)/db/asynRecord.db","P=XPP:DET:TE-TECH2,R=:asyn,PORT=bus1,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure ("bus1","172.21.38.24:2010", 0, 0, 0)

# Asyn tracing settings
asynSetTraceMask("bus0", 0, 0x1) # logging for normal operation
asynSetTraceMask("bus1", 0, 0x1) # logging for normal operation

## Load record instances TE tech & detector instances
dbLoadRecords("db/iocSoft.db",            "IOC=$(IOC_PV)")
dbLoadRecords("db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):")

# Load TE tech & detector instances
dbLoadRecords("db/TE_tech.db",  "TE_cont=XPP:DET:TE-TECH1, bus=0")
dbLoadRecords("db/TE_tech.db",  "TE_cont=XPP:DET:TE-TECH2, bus=1")
dbLoadRecords($(DETDB_EPICS), "PRED=XPP:DET, PRE=XPP:DET, MPDQ0=0, MPAQ0=1, MPDQ1=2, MPAQ1=3, MPDQ2=4, MPAQ2=5, MPDQ3=6, MPAQ3=7, MPHQ0=200, MPHQ1=201, MPHQ2=202, MPHQ3=203, MPC=102, DET=XPP:USER:DET")

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

## Start autosave backups
create_monitor_set( "$(IOC).req", 5, "IOC=$(IOC_PV)" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
