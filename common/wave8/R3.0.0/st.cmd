#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/wave8Ioc

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
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES", "10000000")

# Register all support components
dbLoadDatabase("dbd/wave8Ioc.dbd")
wave8Ioc_registerRecordDeviceDriver(pdbbase)

ErDebugLevel( 0 )

$$LOOP(EVR)
# Initialize EVR
ErConfigure( $$IF(CARD,$$CARD,$$INDEX), 0, 0, 0, $(EVRID_$$TYPE) )

# Load EVR record instances
dbLoadRecords( $(EVRDB_$$TYPE), "IOC=$$(IOC_PV),EVR=$$(NAME),CARD=$$IF(CARD,$$CARD,$$INDEX)$$LOOP(WAVE8),IP$$(TRIG)E=Enabled$$ENDLOOP(WAVE8)$$LOOP(RUNTRIG),IP$$(TRIG)E=Enabled$$ENDLOOP(RUNTRIG)" )
$$ENDLOOP(EVR)

$$LOOP(PGP)
PgpRegister($$NAME, $$MASK, 0x3, $$IF(SRPV3,$$SRPV3,0))
$$ENDLOOP(PGP)

$$LOOP(WAVE8)
Wave8Register($$NAME, $$BOX, $$EVRNAME, 0x$$TRIG, $$IF(BLDID,$$BLDID,255))
$$ENDLOOP(WAVE8)

$$LOOP(WAVE8)
$$IF(AUTO,1)
Wave8Auto 1
$$ELSE(AUTO)
Wave8Auto 0
$$ENDIF(AUTO)
$$ENDLOOP(WAVE8)

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):" )

$$LOOP(WAVE8)
dbLoadRecords("db/wave8$$IF(SIMPLE,simple,).db", "IOCNAME=$$IOCNAME,IOC=$(IOC_PV),BASE=$$NAME,BOX=$$BOX,EVR=$$EVRNAME,TRIG=$$TRIG")
$$IF(BLDID)
dbLoadRecords("db/bldSettings.db", "BLD=$(IOC_PV):B$$INDEX,BLDNO=$$INDEX" )
$$ENDIF(BLDID)
dbLoadRecords("db/evralias.db", "WAVE8=$$NAME,EVR=$$EVRNAME,CH=$$TRIG")
$$ENDLOOP(WAVE8)
$$LOOP(PORTALIAS)
$$LOOP(WAVE8)
dbLoadRecords("db/wave8alias.db", "OLD=$$NAME:AMPL_$$PORT,NEW=$$ALIAS")
$$ENDLOOP(WAVE8)
$$ENDLOOP(PORTALIAS)

# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "$(IOCNAME).sav" )
set_pass1_restoreFile( "autoSettings.sav" )
set_pass1_restoreFile( "$(IOCNAME).sav" )

# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req", 5, "" )
create_monitor_set( "$(IOCNAME).req", 5, "" )

Wave8StartAll()
$$LOOP(WAVE8)
$$IF(BLDID)
BldSetID($$INDEX)
# Datatype is Id_BeamMonitorBldData V1 (98), Version 1 = 65634
#             sAddr              uPort maxsize itf physid xtcid pretrigger              posttrigger        fiducial
BldConfig( "239.255.24.$$BLDID", 10148, 1512, 0, $$BLDID, 65634, "$$NAME:CURRENTFID", "$$NAME:YPOS", "$$NAME:CURRENTFID","$$NAME:SUM,$$NAME:XPOS,$$NAME:YPOS$$LOOP(16),$$NAME:AMPL_$$(INDEX)$$ENDLOOP(16)$$LOOP(16),$$NAME:TPOS_$$(INDEX)$$ENDLOOP(16)" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
$$(NOBLD)BldStart()
BldShowConfig()
$$ENDIF(BLDID)
$$ENDLOOP(WAVE8)

# Configure the WAVE8s.
$$LOOP(WAVE8)
$$IF(NOCFG,#,)dbpf $$NAME:DO_CONFIG.PROC 1
$$ENDLOOP(WAVE8)

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
