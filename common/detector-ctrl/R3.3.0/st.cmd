#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/detector

< envPaths
epicsEnvSet("IOCNAME",   "$$IOCNAME")
epicsEnvSet("ENGINEER",  "$$ENGINEER")
epicsEnvSet("LOCATION",  "$$LOCATION")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> ")
epicsEnvSet("IOC_PV",    "$$IOC_PV")
epicsEnvSet("IOCTOP",    "$$IOCTOP")
epicsEnvSet("TOP",       "$$TOP")
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
$$LOOP(TE_TECH)
dbLoadRecords("$(ASYN)/db/asynRecord.db","P=$$NAME,R=:asyn,PORT=bus$$INDEX,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure ("bus$$INDEX","$$PORT", 0, 0, 0)
$$ENDLOOP(TE_TECH)

# Asyn tracing settings
$$LOOP(TE_TECH)
$$IF(ASYNTRACE)
asynSetTraceFile("bus$$INDEX", 0, "$(IOC_DATA)/$(IOCNAME)/iocInfo/asyn$$INDEX.log")
asynSetTraceMask("bus$$INDEX", 0, 0x1f) # log everything
asynSetTraceIOMask("bus$$INDEX", 0, 0x6)
$$ELSE(ASYNTRACE)
asynSetTraceMask("bus$$INDEX", 0, 0x1) # logging for normal operation
$$ENDIF(ASYNTRACE)
$$ENDLOOP(TE_TECH)

## Load record instances TE tech & detector instances
dbLoadRecords("db/iocSoft.db",            "IOC=$(IOC_PV)")
dbLoadRecords("db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):")

# Load TE tech & detector instances
$$LOOP(TE_TECH)
dbLoadRecords("db/TE_tech.db",  "TE_cont=$$NAME, bus=$$INDEX")
$$ENDLOOP(TE_TECH)
$$LOOP(CSPAD)
dbLoadRecords($(DETDB_$$IF(TEMP,$$TEMP,EPICS)), "PRED=$$NAME, PRE=$$MPOD, MPDQ0=$$(ADLVMOD)0, MPAQ0=$$(ADLVMOD)1, MPDQ1=$$(ADLVMOD)2, MPAQ1=$$(ADLVMOD)3, MPDQ2=$$(ADLVMOD)4, MPAQ2=$$(ADLVMOD)5, MPDQ3=$$(ADLVMOD)6, MPAQ3=$$(ADLVMOD)7, MPHQ0=$$(HVMOD)0, MPHQ1=$$(HVMOD)1, MPHQ2=$$(HVMOD)2, MPHQ3=$$(HVMOD)3, MPC=$$(CMOD)2, DET=$$DET")
$$ENDLOOP(CSPAD)
$$LOOP(CSPAD140k)
dbLoadRecords("db/detector-140k.db", "DET=$$NAME, PREM=$$MPOD, DLVCHN=$$DLVCHN, ALVCHN=$$ALVCHN, HVCHN=$$HVCHN")
$$ENDLOOP(CSPAD140k)
$$LOOP(EPIX)
dbLoadRecords("db/detector-epix-peltier.db", "DET=$$NAME, PREM=$$MPOD, DLVCHN=$$DLVCHN, ALVCHN=$$ALVCHN, PLVCHN=$$PLVCHN, HVCHN=$$HVCHN")
$$ENDLOOP(EPIX)
$$LOOP(CSPADARC)
#dbLoadRecords("db/mec-detector-arcs.db", "PRE=$$NAME, PREM=$$MPOD, NMOD1=CSPAD:1, NMOD2=CSPAD:2, NMOD3=CSPAD:3, NMOD4=CSPAD:4, NMOD5=CSPAD:5, NMOD6=CSPAD:6, NMOD7=CSPAD:7, NMOD8=CSPAD:8, USERPV=$$(NAME):CSPAD")

dbLoadRecords("db/cspad-140k.db", "AREA=$$NAME, MOD=1, MPD=$$MPOD, BIAS=0, DVDD=100, AVDD=101")
dbLoadRecords("db/cspad-140k.db", "AREA=$$NAME, MOD=2, MPD=$$MPOD, BIAS=1, DVDD=102, AVDD=103")
dbLoadRecords("db/cspad-140k.db", "AREA=$$NAME, MOD=3, MPD=$$MPOD, BIAS=2, DVDD=104, AVDD=105")
dbLoadRecords("db/cspad-140k.db", "AREA=$$NAME, MOD=4, MPD=$$MPOD, BIAS=3, DVDD=106, AVDD=107")
dbLoadRecords("db/cspad-140k.db", "AREA=$$NAME, MOD=5, MPD=$$MPOD, BIAS=4, DVDD=200, AVDD=201")
dbLoadRecords("db/cspad-140k.db", "AREA=$$NAME, MOD=6, MPD=$$MPOD, BIAS=5, DVDD=202, AVDD=203")
dbLoadRecords("db/cspad-140k.db", "AREA=$$NAME, MOD=7, MPD=$$MPOD, BIAS=6, DVDD=204, AVDD=205")
dbLoadRecords("db/cspad-140k.db", "AREA=$$NAME, MOD=8, MPD=$$MPOD, BIAS=7, DVDD=206, AVDD=207")
$$ENDLOOP(CSPADARC)

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
