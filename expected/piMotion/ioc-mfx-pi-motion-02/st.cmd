#!/reg/g/pcds/epics/ioc/common/piMotion/R1.2.3/bin/rhel7-x86_64/piMotion
epicsEnvSet("IOCNAME", "ioc-mfx-pi-motion-02")
epicsEnvSet("ENGINEER", "Alex Batyuk (batyuk)" )
epicsEnvSet("LOCATION", "MFX HERA" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:MFX:PIZ:02")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/piMotion/R1.2.3")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/mfx/piMotion/R1.0.0/build")
cd( "$(IOCTOP)" )

epicsEnvSet("STREAM_PROTOCOL_PATH", "./piMotionApp/protocols")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/piMotion.dbd")
piMotion_registerRecordDeviceDriver(pdbbase)

# Black magic to prevent "active scan count exceeded"
scanOnceSetQueueSize(4000)



epicsEnvSet("PORT", "MFX02")

drvAsynIPPortConfigure("$(PORT)","moxa-mfx-hera:4002",0,0,0)
# Optional: Enable tracing
#asynSetTraceIOMask( "$(PORT)",        0,              2 )
#asynSetTraceMask(   "$(PORT)",        0,              9 )

# Load record instances
dbLoadRecords( "db/iocSoft.db",            "IOC=IOC:MFX:PIZ:02" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=IOC:MFX:PIZ:02" )

dbLoadRecords("db/asynRecord.db","P=MFX:HRA:PIZ:02,R=:AsynIO,PORT=$(PORT),ADDR=0,IMAX=0,OMAX=0" )
dbLoadRecords("db/piMotion861.db","NAME=MFX:HRA:PIZ:02,MOTOR=1,AXISID=1,PORT=$(PORT),SCAN=.5 second,MODEL=E-861,DONE=$(PORT):DNCTR.A,NOSENSOR=1")
dbLoadRecords("db/piMotionGCS2openloop.db","NAME=MFX:HRA:PIZ:02,MOTOR=1,AXISID=1,PORT=$(PORT),SCAN=.5 second,MODEL=E-861")


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


# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )
create_monitor_set("autoSettings.req", 5, "")
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV)" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
