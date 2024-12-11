#!/reg/g/pcds/epics/ioc/common/detector-ctrl/R3.3.0/bin/rhel7-x86_64/detector

< envPaths
epicsEnvSet("IOCNAME",   "ioc-mec-cspad-140k")
epicsEnvSet("ENGINEER",  "Jing Yin (jyin)")
epicsEnvSet("LOCATION",  "MEC:CSPAD:140K")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> ")
epicsEnvSet("IOC_PV",    "IOC:MEC:CSPAD:140K")
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
#dbLoadRecords("db/mec-detector-arcs.db", "PRE=MEC, PREM=MEC:D60, NMOD1=CSPAD:1, NMOD2=CSPAD:2, NMOD3=CSPAD:3, NMOD4=CSPAD:4, NMOD5=CSPAD:5, NMOD6=CSPAD:6, NMOD7=CSPAD:7, NMOD8=CSPAD:8, USERPV=MEC:CSPAD")

dbLoadRecords("db/cspad-140k.db", "AREA=MEC, MOD=1, MPD=MEC:D60, BIAS=0, DVDD=100, AVDD=101")
dbLoadRecords("db/cspad-140k.db", "AREA=MEC, MOD=2, MPD=MEC:D60, BIAS=1, DVDD=102, AVDD=103")
dbLoadRecords("db/cspad-140k.db", "AREA=MEC, MOD=3, MPD=MEC:D60, BIAS=2, DVDD=104, AVDD=105")
dbLoadRecords("db/cspad-140k.db", "AREA=MEC, MOD=4, MPD=MEC:D60, BIAS=3, DVDD=106, AVDD=107")
dbLoadRecords("db/cspad-140k.db", "AREA=MEC, MOD=5, MPD=MEC:D60, BIAS=4, DVDD=200, AVDD=201")
dbLoadRecords("db/cspad-140k.db", "AREA=MEC, MOD=6, MPD=MEC:D60, BIAS=5, DVDD=202, AVDD=203")
dbLoadRecords("db/cspad-140k.db", "AREA=MEC, MOD=7, MPD=MEC:D60, BIAS=6, DVDD=204, AVDD=205")
dbLoadRecords("db/cspad-140k.db", "AREA=MEC, MOD=8, MPD=MEC:D60, BIAS=7, DVDD=206, AVDD=207")

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
