#!/reg/g/pcds/epics/ioc/common/detector-ctrl/R3.3.0/bin/rhel7-x86_64/detector

< envPaths
epicsEnvSet("IOCNAME",   "ioc-mec-cspad-550k")
epicsEnvSet("ENGINEER",  "Jing Yin (jyin)")
epicsEnvSet("LOCATION",  "MEC:CSPAD:550K")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> ")
epicsEnvSet("IOC_PV",    "IOC:MEC:CSPAD:550K")
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

# Asyn tracing settings

## Load record instances TE tech & detector instances
dbLoadRecords("db/iocSoft.db",            "IOC=$(IOC_PV)")
dbLoadRecords("db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):")

# Load TE tech & detector instances
dbLoadRecords($(DETDB_NONE), "PRED=MEC:CSPAD:550K, PRE=MEC:D60, MPDQ0=100, MPAQ0=101, MPDQ1=102, MPAQ1=103, MPDQ2=104, MPAQ2=105, MPDQ3=106, MPAQ3=107, MPHQ0=0, MPHQ1=1, MPHQ2=2, MPHQ3=3, MPC=202, DET=MEC:USER:CSPAD:550K")

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
