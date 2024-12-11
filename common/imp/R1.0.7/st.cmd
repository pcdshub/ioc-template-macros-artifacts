#!$$IOCTOP/bin/linux-x86_64/impIoc

epicsEnvSet("IOCNAME", "$$IOCNAME" )
epicsEnvSet("ENGINEER", "$$ENGINEER" )
epicsEnvSet("LOCATION", "$$LOCATION" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "$$IOC_PV")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet("IOCTOP", "$$IOCTOP")

< envPaths
epicsEnvSet("TOP", "$$TOP")
cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/impIoc.dbd")
impIoc_registerRecordDeviceDriver(pdbbase)

ErDebugLevel( 0 )

$$LOOP(EVR)
# Initialize EVR
ErConfigure( $$IF(CARD,$$CARD,$$INDEX), 0, 0, 0, $(EVRID_$$TYPE) )

# Load EVR record instances
dbLoadRecords( $(EVRDB_$$TYPE), "IOC=$$(IOC_PV),EVR=$$(NAME),CARD=$$IF(CARD,$$CARD,$$INDEX)$$LOOP(IMP),IP$$(TRIG)E=Enabled$$ENDLOOP(IMP)$$LOOP(USETRIG),IP$$(TRIG)E=Enabled$$ENDLOOP(USETRIG)" )
$$ENDLOOP(EVR)

$$LOOP(PGP)
PgpRegister($$NAME, $$MASK)
$$ENDLOOP(PGP)

$$LOOP(IMP)
Imp$$IF(TYPE,$$TYPE,2)Register($$NAME, $$BOX, $$EVRNAME, 0x$$TRIG, $$IF(BLDID,$$BLDID,255))
$$ENDLOOP(IMP)

$$LOOP(IMP)
$$IF(TYPE,2)
$$IF(AUTO,1)
Imp2Auto 1
$$ELSE(AUTO)
Imp2Auto 0
$$ENDIF(AUTO)
$$ENDIF(TYPE)
$$ENDLOOP(IMP)

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )

$$LOOP(IMP)
dbLoadRecords("db/imp$$IF(TYPE,$$TYPE,2).db", "IOC=$(IOC_PV),BASE=$$NAME,BOX=$$BOX,EVR=$$EVRNAME,TRIG=$$TRIG,DATALNK=$$DATALNK")
dbLoadRecords("db/evrDevInfo.db", "BASE=$$NAME,EVR=$$EVRNAME,TRIG=$$TRIG,NAME=$$NAME")
$$IF(BLDID)
dbLoadRecords("db/bldSettings.db", "BLD=$(IOC_PV):B$$INDEX,BLDNO=$$INDEX" )
$$ENDIF(BLDID)
$$ENDLOOP(IMP)

$$LOOP(IPIMB)
$$ENDLOOP(IPIMB)

# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "$(IOCNAME).sav" )
set_pass1_restoreFile( "$(IOCNAME).sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV)" )

ImpStartAll()
$$LOOP(IMP)
$$IF(BLDID)
BldSetID($$INDEX)
$$IF(TYPE,1)
# Datatype is Id_SharedIpimb (35), Version 1, so 65536+35 = 65571
BldConfig( "239.255.24.$$BLDID", 10148, 512, 0, $$BLDID, 65571, "$$NAME:CURRENTFID", "$$NAME:YPOS", "$$NAME:CURRENTFID", "$$NAME:RAW.INP,$$NAME:CH0,$$NAME:CH1,$$NAME:CH2,$$NAME:CH3,$$NAME:SUM,$$NAME:XPOS,$$NAME:YPOS" )
$$ELSE(TYPE)
# Datatype is Id_BeamMonitorBldData (98), Version 0.
BldConfig( "239.255.24.$$BLDID", 10148, 1512, 0, $$BLDID, 98, "$$NAME:CURRENTFID", "$$NAME:_Y_Position", "$$NAME:CURRENTFID","$$NAME:_TotalIntensity,$$NAME:_X_Position,$$NAME:_Y_Position$$LOOP(16),$$NAME:_peakA_$$(INDEX)$$ENDLOOP(16)$$LOOP(16),$$NAME:_peakT_$$(INDEX)$$ENDLOOP(16)" )
$$ENDIF(TYPE)
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
$$(NOBLD)BldStart()
BldShowConfig()
$$ENDIF(BLDID)
$$ENDLOOP(IMP)

# Configure the IMPs.
$$LOOP(IMP)
$$IF(NOCFG,#,)dbpf $$NAME:DO_CONFIG.PROC 1
$$ENDLOOP(IMP)

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
