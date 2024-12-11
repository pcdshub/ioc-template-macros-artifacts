#!/cds/group/pcds/epics/ioc/common/wave8/R3.0.0/bin/rhel7-x86_64/wave8Ioc

epicsEnvSet("IOCNAME", "ioc-xcs-snd-bmmon" )
epicsEnvSet("ENGINEER", "Opperman" )
epicsEnvSet("LOCATION", "XRT Alcove" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:XCS:SND:DIO")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet("IOCTOP", "/cds/group/pcds/epics/ioc/common/wave8/R3.0.0")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/xcs/wave8/R3.0.0/build")
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
dbLoadRecords( $(EVRDB_SLAC), "IOC=IOC:XCS:SND:DIO,EVR=XCS:SND:DIO:EVR,CARD=0,IP1E=Enabled,IP0E=Enabled" )

PgpRegister(PGP0, 0x10, 0x3, 0)

Wave8Register(XCS:SND:DIO, PGP0, XCS:SND:DIO:EVR, 0x1, 73)

Wave8Auto 0

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):" )

dbLoadRecords("db/wave8.db", "IOCNAME=ioc-xcs-snd-bmmon,IOC=$(IOC_PV),BASE=XCS:SND:DIO,BOX=PGP0,EVR=XCS:SND:DIO:EVR,TRIG=1")
dbLoadRecords("db/bldSettings.db", "BLD=$(IOC_PV):B0,BLDNO=0" )
dbLoadRecords("db/evralias.db", "WAVE8=XCS:SND:DIO,EVR=XCS:SND:DIO:EVR,CH=1")
dbLoadRecords("db/wave8alias.db", "OLD=XCS:SND:DIO:AMPL_8,NEW=XCS:SND:DIA:DCC:DIODE")
dbLoadRecords("db/wave8alias.db", "OLD=XCS:SND:DIO:AMPL_9,NEW=XCS:SND:DIA:DCO:DIODE")
dbLoadRecords("db/wave8alias.db", "OLD=XCS:SND:DIO:AMPL_10,NEW=XCS:SND:DIA:DO:DIODE")
dbLoadRecords("db/wave8alias.db", "OLD=XCS:SND:DIO:AMPL_11,NEW=XCS:SND:DIA:T1D:DIODE")
dbLoadRecords("db/wave8alias.db", "OLD=XCS:SND:DIO:AMPL_12,NEW=XCS:SND:DIA:DD:DIODE")
dbLoadRecords("db/wave8alias.db", "OLD=XCS:SND:DIO:AMPL_13,NEW=XCS:SND:DIA:DCI:DIODE")
dbLoadRecords("db/wave8alias.db", "OLD=XCS:SND:DIO:AMPL_14,NEW=XCS:SND:DIA:DI:DIODE")
dbLoadRecords("db/wave8alias.db", "OLD=XCS:SND:DIO:AMPL_15,NEW=XCS:SND:DIA:T4D:DIODE")

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
BldConfig( "239.255.24.73", 10148, 1512, 0, 73, 65634, "XCS:SND:DIO:CURRENTFID", "XCS:SND:DIO:YPOS", "XCS:SND:DIO:CURRENTFID","XCS:SND:DIO:SUM,XCS:SND:DIO:XPOS,XCS:SND:DIO:YPOS,XCS:SND:DIO:AMPL_0,XCS:SND:DIO:AMPL_1,XCS:SND:DIO:AMPL_2,XCS:SND:DIO:AMPL_3,XCS:SND:DIO:AMPL_4,XCS:SND:DIO:AMPL_5,XCS:SND:DIO:AMPL_6,XCS:SND:DIO:AMPL_7,XCS:SND:DIO:AMPL_8,XCS:SND:DIO:AMPL_9,XCS:SND:DIO:AMPL_10,XCS:SND:DIO:AMPL_11,XCS:SND:DIO:AMPL_12,XCS:SND:DIO:AMPL_13,XCS:SND:DIO:AMPL_14,XCS:SND:DIO:AMPL_15,XCS:SND:DIO:TPOS_0,XCS:SND:DIO:TPOS_1,XCS:SND:DIO:TPOS_2,XCS:SND:DIO:TPOS_3,XCS:SND:DIO:TPOS_4,XCS:SND:DIO:TPOS_5,XCS:SND:DIO:TPOS_6,XCS:SND:DIO:TPOS_7,XCS:SND:DIO:TPOS_8,XCS:SND:DIO:TPOS_9,XCS:SND:DIO:TPOS_10,XCS:SND:DIO:TPOS_11,XCS:SND:DIO:TPOS_12,XCS:SND:DIO:TPOS_13,XCS:SND:DIO:TPOS_14,XCS:SND:DIO:TPOS_15" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

# Configure the WAVE8s.
dbpf XCS:SND:DIO:DO_CONFIG.PROC 1

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
