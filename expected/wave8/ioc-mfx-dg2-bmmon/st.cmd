#!/cds/group/pcds/epics/ioc/common/wave8/R3.0.0/bin/rhel7-x86_64/wave8Ioc

epicsEnvSet("IOCNAME", "ioc-mfx-dg2-bmmon" )
epicsEnvSet("ENGINEER", "Rajan Plumley (rajan-01)" )
epicsEnvSet("LOCATION", "MFX DG2" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:MFX:DG2:BMMON")
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
dbLoadRecords( $(EVRDB_SLAC), "IOC=IOC:MFX:DG2:BMMON,EVR=MFX:DG2:BMMON:EVR,CARD=0,IP1E=Enabled,IP2E=Enabled" )

PgpRegister(PGP0, 0x40, 0x3, 0)

Wave8Register(MFX:DG2:BMMON, PGP0, MFX:DG2:BMMON:EVR, 0x1, 83)

Wave8Auto 0

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):" )

dbLoadRecords("db/wave8.db", "IOCNAME=ioc-mfx-dg2-bmmon,IOC=$(IOC_PV),BASE=MFX:DG2:BMMON,BOX=PGP0,EVR=MFX:DG2:BMMON:EVR,TRIG=1")
dbLoadRecords("db/bldSettings.db", "BLD=$(IOC_PV):B0,BLDNO=0" )
dbLoadRecords("db/evralias.db", "WAVE8=MFX:DG2:BMMON,EVR=MFX:DG2:BMMON:EVR,CH=1")

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
BldConfig( "239.255.24.83", 10148, 1512, 0, 83, 65634, "MFX:DG2:BMMON:CURRENTFID", "MFX:DG2:BMMON:YPOS", "MFX:DG2:BMMON:CURRENTFID","MFX:DG2:BMMON:SUM,MFX:DG2:BMMON:XPOS,MFX:DG2:BMMON:YPOS,MFX:DG2:BMMON:AMPL_0,MFX:DG2:BMMON:AMPL_1,MFX:DG2:BMMON:AMPL_2,MFX:DG2:BMMON:AMPL_3,MFX:DG2:BMMON:AMPL_4,MFX:DG2:BMMON:AMPL_5,MFX:DG2:BMMON:AMPL_6,MFX:DG2:BMMON:AMPL_7,MFX:DG2:BMMON:AMPL_8,MFX:DG2:BMMON:AMPL_9,MFX:DG2:BMMON:AMPL_10,MFX:DG2:BMMON:AMPL_11,MFX:DG2:BMMON:AMPL_12,MFX:DG2:BMMON:AMPL_13,MFX:DG2:BMMON:AMPL_14,MFX:DG2:BMMON:AMPL_15,MFX:DG2:BMMON:TPOS_0,MFX:DG2:BMMON:TPOS_1,MFX:DG2:BMMON:TPOS_2,MFX:DG2:BMMON:TPOS_3,MFX:DG2:BMMON:TPOS_4,MFX:DG2:BMMON:TPOS_5,MFX:DG2:BMMON:TPOS_6,MFX:DG2:BMMON:TPOS_7,MFX:DG2:BMMON:TPOS_8,MFX:DG2:BMMON:TPOS_9,MFX:DG2:BMMON:TPOS_10,MFX:DG2:BMMON:TPOS_11,MFX:DG2:BMMON:TPOS_12,MFX:DG2:BMMON:TPOS_13,MFX:DG2:BMMON:TPOS_14,MFX:DG2:BMMON:TPOS_15" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

# Configure the WAVE8s.
dbpf MFX:DG2:BMMON:DO_CONFIG.PROC 1

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
