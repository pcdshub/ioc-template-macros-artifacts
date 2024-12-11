#!/cds/group/pcds/epics/ioc/common/wave8/R3.0.0/bin/rhel7-x86_64/wave8Ioc

epicsEnvSet("IOCNAME", "ioc-mfx-usr-dio" )
epicsEnvSet("ENGINEER", "Vincent Esposito (espov)" )
epicsEnvSet("LOCATION", "MFX DG3" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:MFX:USR:DIO")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet("IOCTOP", "/cds/group/pcds/epics/ioc/common/wave8/R3.0.0")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/mfx/wave8/R3.0.0/build")
cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES", "10000000")

# Register all support components
dbLoadDatabase("dbd/wave8Ioc.dbd")
wave8Ioc_registerRecordDeviceDriver(pdbbase)

ErDebugLevel( 0 )

# Initialize EVR
ErConfigure( 0, 0, 0, 0, $(EVRID_SLAC) )

# Load EVR record instances
dbLoadRecords( $(EVRDB_SLAC), "IOC=IOC:MFX:USR:DIO,EVR=MFX:USR:DIO:EVR,CARD=0,IP6E=Enabled,IP7E=Enabled" )

PgpRegister(PGP0, 0x20, 0x3, 0)

Wave8Register(MFX:USR:DIO, PGP0, MFX:USR:DIO:EVR, 0x6, 74)

Wave8Auto 0

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):" )

dbLoadRecords("db/wave8.db", "IOCNAME=ioc-mfx-usr-dio,IOC=$(IOC_PV),BASE=MFX:USR:DIO,BOX=PGP0,EVR=MFX:USR:DIO:EVR,TRIG=6")
dbLoadRecords("db/bldSettings.db", "BLD=$(IOC_PV):B0,BLDNO=0" )
dbLoadRecords("db/evralias.db", "WAVE8=MFX:USR:DIO,EVR=MFX:USR:DIO:EVR,CH=6")

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
BldSetID(0)
# Datatype is Id_BeamMonitorBldData V1 (98), Version 1 = 65634
#             sAddr              uPort maxsize itf physid xtcid pretrigger              posttrigger        fiducial
BldConfig( "239.255.24.74", 10148, 1512, 0, 74, 65634, "MFX:USR:DIO:CURRENTFID", "MFX:USR:DIO:YPOS", "MFX:USR:DIO:CURRENTFID","MFX:USR:DIO:SUM,MFX:USR:DIO:XPOS,MFX:USR:DIO:YPOS,MFX:USR:DIO:AMPL_0,MFX:USR:DIO:AMPL_1,MFX:USR:DIO:AMPL_2,MFX:USR:DIO:AMPL_3,MFX:USR:DIO:AMPL_4,MFX:USR:DIO:AMPL_5,MFX:USR:DIO:AMPL_6,MFX:USR:DIO:AMPL_7,MFX:USR:DIO:AMPL_8,MFX:USR:DIO:AMPL_9,MFX:USR:DIO:AMPL_10,MFX:USR:DIO:AMPL_11,MFX:USR:DIO:AMPL_12,MFX:USR:DIO:AMPL_13,MFX:USR:DIO:AMPL_14,MFX:USR:DIO:AMPL_15,MFX:USR:DIO:TPOS_0,MFX:USR:DIO:TPOS_1,MFX:USR:DIO:TPOS_2,MFX:USR:DIO:TPOS_3,MFX:USR:DIO:TPOS_4,MFX:USR:DIO:TPOS_5,MFX:USR:DIO:TPOS_6,MFX:USR:DIO:TPOS_7,MFX:USR:DIO:TPOS_8,MFX:USR:DIO:TPOS_9,MFX:USR:DIO:TPOS_10,MFX:USR:DIO:TPOS_11,MFX:USR:DIO:TPOS_12,MFX:USR:DIO:TPOS_13,MFX:USR:DIO:TPOS_14,MFX:USR:DIO:TPOS_15" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

# Configure the WAVE8s.
dbpf MFX:USR:DIO:DO_CONFIG.PROC 1

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
