#!/reg/g/pcds/epics/ioc/common/piMotion/R1.2.4/bin/linux-x86_64/piMotion
epicsEnvSet("IOCNAME", "ioc-xpp-pi-motion")
epicsEnvSet("ENGINEER", "Michael Browne (mcbrowne)" )
epicsEnvSet("LOCATION", "unknown" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:XPP:LMC:01")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/piMotion/R1.2.4")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/common/piMotion/R1.2.4/children/build")
cd( "$(IOCTOP)" )

epicsEnvSet("STREAM_PROTOCOL_PATH", "./piMotionApp/protocols")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/piMotion.dbd")
piMotion_registerRecordDeviceDriver(pdbbase)

# Black magic to prevent "active scan count exceeded"
scanOnceSetQueueSize(4000)

ErDebugLevel( 0 )

# Initialize EVR
ErConfigure(0, 0, 0, 0, $(EVRID_SLAC))

# Load EVR record instances
dbLoadRecords($(EVRDB_SLAC), "IOC=IOC:XPP:LMC:01,EVR=XPP:LMC:EVR:01,CARD=0,IP3E=Enabled")

epicsEnvSet("PORT", "LMC")

drvAsynIPPortConfigure("$(PORT)","xpp-gleason-lmc:8888",0,0,0)
# Optional: Enable tracing
#asynSetTraceIOMask( "$(PORT)",        0,              2 )
#asynSetTraceMask(   "$(PORT)",        0,              9 )

# Load record instances
dbLoadRecords( "db/iocSoft.db",            "IOC=IOC:XPP:LMC:01" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=IOC:XPP:LMC:01" )

dbLoadRecords("db/asynRecord.db","P=XPP:LMC:01,R=:AsynIO,PORT=$(PORT),ADDR=0,IMAX=0,OMAX=0" )
dbLoadRecords("db/lmc.db","NAME=XPP:LMC:01,TRIG=XPP:LMC:EVR:01:TRIG3,PORT=$(PORT),BLDID=86,START=XPP:USR:EVR:TRIG1,TOMO=XPP:USR:MMS:26")

populateFiles($(PORT), XPP:LMC:01:FILES)


# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "$(IOCNAME).sav" )
set_pass1_restoreFile( "$(IOCNAME).sav" )
set_pass0_restoreFile( "autoSettings.sav" )
set_pass1_restoreFile( "autoSettings.sav" )

# Configure the BLD client
BldConfigSend( "239.255.24.86", 10148, 8000 )
BldStart()
BldIsStarted()

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )
create_monitor_set("autoSettings.req", 5, "")
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV)" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
