#!/reg/g/pcds/epics/ioc/common/detector-ctrl/R3.3.0/bin/rhel7-x86_64/detector

< envPaths
epicsEnvSet("IOCNAME",   "ioc-cxi-csArcD50")
epicsEnvSet("ENGINEER",  "Jason Koglin (koglin)")
epicsEnvSet("LOCATION",  "CXI:D50:IOC:00:DET")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> ")
epicsEnvSet("IOC_PV",    "CXI:IOC:D50:140K")
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
dbLoadRecords("db/detector-140k.db", "DET=CXI:D50:140K:00, PREM=CXI:D50, DLVCHN=100, ALVCHN=101, HVCHN=0")
dbLoadRecords("db/detector-140k.db", "DET=CXI:D50:140K:01, PREM=CXI:D50, DLVCHN=102, ALVCHN=103, HVCHN=1")
dbLoadRecords("db/detector-140k.db", "DET=CXI:D50:140K:02, PREM=CXI:D50, DLVCHN=104, ALVCHN=105, HVCHN=2")
dbLoadRecords("db/detector-140k.db", "DET=CXI:D50:140K:03, PREM=CXI:D50, DLVCHN=105, ALVCHN=107, HVCHN=3")
dbLoadRecords("db/detector-140k.db", "DET=CXI:D50:140K:04, PREM=CXI:D50, DLVCHN=200, ALVCHN=201, HVCHN=4")
dbLoadRecords("db/detector-140k.db", "DET=CXI:D50:140K:05, PREM=CXI:D50, DLVCHN=202, ALVCHN=203, HVCHN=5")
dbLoadRecords("db/detector-140k.db", "DET=CXI:D50:140K:06, PREM=CXI:D50, DLVCHN=204, ALVCHN=205, HVCHN=6")
dbLoadRecords("db/detector-140k.db", "DET=CXI:D50:140K:07, PREM=CXI:D50, DLVCHN=206, ALVCHN=207, HVCHN=7")

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
