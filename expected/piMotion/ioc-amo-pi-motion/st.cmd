#!/reg/g/pcds/epics/ioc/common/piMotion/R1.2.4/bin/linux-x86_64/piMotion
epicsEnvSet("IOCNAME", "ioc-amo-pi-motion")
epicsEnvSet("ENGINEER", "Michael Browne (mcbrowne)" )
epicsEnvSet("LOCATION", "unknown" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "AMO:SDL:IOC:40:pi")
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



epicsEnvSet("PORT", "AMO:SDL:PIZ:01")

drvAsynIPPortConfigure("$(PORT)","motion-amo-pi-01:50000",0,0,0)
# Optional: Enable tracing
#asynSetTraceIOMask( "$(PORT)",        0,              2 )
#asynSetTraceMask(   "$(PORT)",        0,              9 )

# Load record instances
dbLoadRecords( "db/iocSoft.db",            "IOC=AMO:SDL:IOC:40:pi" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=AMO:SDL:IOC:40:pi" )

dbLoadRecords("db/asynRecord.db","P=AMO:SDL:MZM:01,R=:AsynIO,PORT=$(PORT),ADDR=0,IMAX=0,OMAX=0" )
dbLoadRecords("db/piMotion727.db","NAME=AMO:SDL:MZM:01,MOTOR=1,AXISID=A,PORT=$(PORT),SCAN=.1 second,MODEL=E-517,DONE=$(PORT):DNCTR.A")
dbLoadRecords("db/piMotion517.db","NAME=AMO:SDL:MZM:01,MOTOR=1,AXISID=A,PORT=$(PORT),SCAN=.1 second")
dbLoadRecords("db/asynRecord.db","P=AMO:SDL:MZM:02,R=:AsynIO,PORT=$(PORT),ADDR=0,IMAX=0,OMAX=0" )
dbLoadRecords("db/piMotion727.db","NAME=AMO:SDL:MZM:02,MOTOR=2,AXISID=B,PORT=$(PORT),SCAN=.1 second,MODEL=E-517,DONE=$(PORT):DNCTR.B")
dbLoadRecords("db/piMotion517.db","NAME=AMO:SDL:MZM:02,MOTOR=2,AXISID=B,PORT=$(PORT),SCAN=.1 second")
dbLoadRecords("db/asynRecord.db","P=AMO:SDL:MZM:03,R=:AsynIO,PORT=$(PORT),ADDR=0,IMAX=0,OMAX=0" )
dbLoadRecords("db/piMotion727.db","NAME=AMO:SDL:MZM:03,MOTOR=3,AXISID=C,PORT=$(PORT),SCAN=.1 second,MODEL=E-517,DONE=$(PORT):DNCTR.C")
dbLoadRecords("db/piMotion517.db","NAME=AMO:SDL:MZM:03,MOTOR=3,AXISID=C,PORT=$(PORT),SCAN=.1 second")


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
