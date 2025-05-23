#!/cds/group/pcds/epics/ioc/common/wave8/R3.0.0/bin/rhel7-x86_64/wave8Ioc

epicsEnvSet("IOCNAME", "ioc-mec-xt2-1-bmmon" )
epicsEnvSet("ENGINEER", "Tyler Johnson (tjohnson)" )
epicsEnvSet("LOCATION", "MEC XT2 (first stand)" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:MEC:XT2-1:BMMON")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet("IOCTOP", "/cds/group/pcds/epics/ioc/common/wave8/R3.0.0")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/mec/wave8/R3.0.0/build")
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
dbLoadRecords( $(EVRDB_SLAC), "IOC=IOC:MEC:XT2-1:BMMON,EVR=MEC:XT2-1:BMMON:EVR,CARD=0,IP0E=Enabled,IP1E=Enabled" )

PgpRegister(PGP0, 0x10, 0x3, 0)

Wave8Register(MEC:XT2-1:BMMON, PGP0, MEC:XT2-1:BMMON:EVR, 0x0, 87)

Wave8Auto 0

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):" )

dbLoadRecords("db/wave8.db", "IOCNAME=ioc-mec-xt2-1-bmmon,IOC=$(IOC_PV),BASE=MEC:XT2-1:BMMON,BOX=PGP0,EVR=MEC:XT2-1:BMMON:EVR,TRIG=0")
dbLoadRecords("db/bldSettings.db", "BLD=$(IOC_PV):B0,BLDNO=0" )
dbLoadRecords("db/evralias.db", "WAVE8=MEC:XT2-1:BMMON,EVR=MEC:XT2-1:BMMON:EVR,CH=0")

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
BldConfig( "239.255.24.87", 10148, 1512, 0, 87, 65634, "MEC:XT2-1:BMMON:CURRENTFID", "MEC:XT2-1:BMMON:YPOS", "MEC:XT2-1:BMMON:CURRENTFID","MEC:XT2-1:BMMON:SUM,MEC:XT2-1:BMMON:XPOS,MEC:XT2-1:BMMON:YPOS,MEC:XT2-1:BMMON:AMPL_0,MEC:XT2-1:BMMON:AMPL_1,MEC:XT2-1:BMMON:AMPL_2,MEC:XT2-1:BMMON:AMPL_3,MEC:XT2-1:BMMON:AMPL_4,MEC:XT2-1:BMMON:AMPL_5,MEC:XT2-1:BMMON:AMPL_6,MEC:XT2-1:BMMON:AMPL_7,MEC:XT2-1:BMMON:AMPL_8,MEC:XT2-1:BMMON:AMPL_9,MEC:XT2-1:BMMON:AMPL_10,MEC:XT2-1:BMMON:AMPL_11,MEC:XT2-1:BMMON:AMPL_12,MEC:XT2-1:BMMON:AMPL_13,MEC:XT2-1:BMMON:AMPL_14,MEC:XT2-1:BMMON:AMPL_15,MEC:XT2-1:BMMON:TPOS_0,MEC:XT2-1:BMMON:TPOS_1,MEC:XT2-1:BMMON:TPOS_2,MEC:XT2-1:BMMON:TPOS_3,MEC:XT2-1:BMMON:TPOS_4,MEC:XT2-1:BMMON:TPOS_5,MEC:XT2-1:BMMON:TPOS_6,MEC:XT2-1:BMMON:TPOS_7,MEC:XT2-1:BMMON:TPOS_8,MEC:XT2-1:BMMON:TPOS_9,MEC:XT2-1:BMMON:TPOS_10,MEC:XT2-1:BMMON:TPOS_11,MEC:XT2-1:BMMON:TPOS_12,MEC:XT2-1:BMMON:TPOS_13,MEC:XT2-1:BMMON:TPOS_14,MEC:XT2-1:BMMON:TPOS_15" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

# Configure the WAVE8s.
dbpf MEC:XT2-1:BMMON:DO_CONFIG.PROC 1

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
