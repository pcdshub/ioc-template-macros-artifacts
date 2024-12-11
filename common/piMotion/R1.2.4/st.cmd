#!$$IOCTOP/bin/linux-x86_64/piMotion
epicsEnvSet("IOCNAME", "$$IOCNAME")
epicsEnvSet("ENGINEER", "$$ENGINEER" )
epicsEnvSet("LOCATION", "$$LOCATION" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "$$IOC_PV")
epicsEnvSet("IOCTOP", "$$IOCTOP")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")

< envPaths
epicsEnvSet("TOP", "$$TOP")
cd( "$(IOCTOP)" )

epicsEnvSet("STREAM_PROTOCOL_PATH", "./piMotionApp/protocols")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/piMotion.dbd")
piMotion_registerRecordDeviceDriver(pdbbase)

# Black magic to prevent "active scan count exceeded"
scanOnceSetQueueSize(4000)

$$LOOP(EVR)
ErDebugLevel( 0 )
$$ENDLOOP(EVR)

$$LOOP(EVR)
# Initialize EVR
ErConfigure($$IF(CARD,$$CARD,$$INDEX), 0, 0, 0, $(EVRID_$$TYPE))

# Load EVR record instances
dbLoadRecords($(EVRDB_$$TYPE), "IOC=$$(IOC_PV),EVR=$$(NAME),CARD=$$IF(CARD,$$CARD,$$INDEX)$$LOOP(AI)$$IF(TRIG),IP$$(TRIG)E=Enabled$$ENDIF(TRIG)$$ENDLOOP(AI)$$LOOP(USETRIG),IP$$(TRIG)E=Enabled$$ENDLOOP(USETRIG)$$LOOP(MOTOR)$$IF(TRIG),IP$$(TRIG)E=Enabled$$ENDIF(TRIG)$$ENDLOOP(MOTOR)")
$$ENDLOOP(EVR)

epicsEnvSet("PORT", "$$PORTNAME")

drvAsynIPPortConfigure("$(PORT)","$$PORTSPEC",0,0,0)
# Optional: Enable tracing
$$IF(TRACE)$$ELSE(TRACE)#$$ENDIF(TRACE)asynSetTraceIOMask( "$(PORT)",        0,              2 )
$$IF(TRACE)$$ELSE(TRACE)#$$ENDIF(TRACE)asynSetTraceMask(   "$(PORT)",        0,              9 )

# Load record instances
dbLoadRecords( "db/iocSoft.db",            "IOC=$$IOC_PV" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$$IOC_PV" )

$$LOOP(MOTOR)
dbLoadRecords("db/asynRecord.db","P=$$NAME,R=:AsynIO,PORT=$(PORT),ADDR=0,IMAX=0,OMAX=0" )
$$IF(MODEL,E-727)
dbLoadRecords("db/piMotion727.db","NAME=$$NAME,MOTOR=$$AXIS,AXISID=$$AXIS,PORT=$(PORT),SCAN=$$IF(SCAN,$$SCAN,.1 second),MODEL=$$MODEL,DONE=$(PORT):DNCTR.$$TRANSLATE(AXIS,"123","ABC")")
$$ENDIF(MODEL)
$$IF(MODEL,E-517)
dbLoadRecords("db/piMotion727.db","NAME=$$NAME,MOTOR=$$AXIS,AXISID=$$TRANSLATE(AXIS,"123","ABC"),PORT=$(PORT),SCAN=$$IF(SCAN,$$SCAN,.1 second),MODEL=$$MODEL,DONE=$(PORT):DNCTR.$$TRANSLATE(AXIS,"123","ABC")")
dbLoadRecords("db/piMotion517.db","NAME=$$NAME,MOTOR=$$AXIS,AXISID=$$TRANSLATE(AXIS,"123","ABC"),PORT=$(PORT),SCAN=$$IF(SCAN,$$SCAN,.1 second)")
$$ENDIF(MODEL)
$$IF(MODEL,E-861)
dbLoadRecords("db/piMotion861.db","NAME=$$NAME,MOTOR=$$AXIS,AXISID=$$AXIS,PORT=$(PORT),SCAN=$$IF(SCAN,$$SCAN,.1 second),MODEL=$$MODEL,DONE=$(PORT):DNCTR.$$TRANSLATE(AXIS,"123","ABC"),NOSENSOR=$$IF(NOSENSOR,1,0)")
dbLoadRecords("db/piMotionGCS2openloop.db","NAME=$$NAME,MOTOR=$$AXIS,AXISID=$$AXIS,PORT=$(PORT),SCAN=$$IF(SCAN,$$SCAN,.1 second),MODEL=$$MODEL")
$$ENDIF(MODEL)
$$IF(MODEL,LMC)
dbLoadRecords("db/lmc.db","NAME=$$NAME,TRIG=$$EVRNAME:TRIG$$TRIG,PORT=$(PORT),BLDID=$$IF(BLDID,$$BLDID,255),START=$$START,TOMO=$$TOMO")

populateFiles($(PORT), $$NAME:FILES)
$$ENDIF(MODEL)
$$ENDLOOP(MOTOR)

$$IF(BLDID)
$$IF(MODEL,LMC)$$ELSE(MODEL)
dbLoadRecords("db/controller.db","NAME=$(PORT),PORT=$(PORT),SCAN=.1 second,MODEL=$$MODEL$$LOOP(MOTOR),M$$INDEX=$$NAME$$ENDLOOP(MOTOR),BLDID=$$BLDID")
$$ENDIF(MODEL)
$$ENDIF(BLDID)

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

$$IF(BLDID)
# Configure the BLD client
BldConfigSend( "239.255.24.$$BLDID", 10148, 8000 )
$$IF(DISABLE_BLD)#$$ENDIF(DISABLE_BLD)BldStart()
BldIsStarted()
$$ENDIF(BLDID)

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )
create_monitor_set("autoSettings.req", 5, "")
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV)" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
