#!/reg/g/pcds/epics/ioc/common/wave8/R3.0.0/bin/rhel7-x86_64/wave8Ioc

epicsEnvSet("IOCNAME", "ioc-xcs-bmmon" )
epicsEnvSet("ENGINEER", "Michael Browne (mcbrowne)" )
epicsEnvSet("LOCATION", "unknown" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:XCS:BMMON")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/wave8/R3.0.0")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/common/wave8/R3.0.0/children/build")
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
dbLoadRecords( $(EVRDB_SLAC), "IOC=IOC:XCS:BMMON,EVR=EVR:XCS:BMMON,CARD=0,IP1E=Enabled,IP0E=Enabled" )

PgpRegister(PGP0, 0x80, 0x3, 0)

Wave8Register(WV8:XCS:BMMON, PGP0, EVR:XCS:BMMON, 0x1, 62)

Wave8Auto 0

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):" )

dbLoadRecords("db/wave8.db", "IOCNAME=ioc-xcs-bmmon,IOC=$(IOC_PV),BASE=WV8:XCS:BMMON,BOX=PGP0,EVR=EVR:XCS:BMMON,TRIG=1")
dbLoadRecords("db/bldSettings.db", "BLD=$(IOC_PV):B0,BLDNO=0" )
dbLoadRecords("db/evralias.db", "WAVE8=WV8:XCS:BMMON,EVR=EVR:XCS:BMMON,CH=1")

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
BldConfig( "239.255.24.62", 10148, 1512, 0, 62, 65634, "WV8:XCS:BMMON:CURRENTFID", "WV8:XCS:BMMON:YPOS", "WV8:XCS:BMMON:CURRENTFID","WV8:XCS:BMMON:SUM,WV8:XCS:BMMON:XPOS,WV8:XCS:BMMON:YPOS,WV8:XCS:BMMON:AMPL_0,WV8:XCS:BMMON:AMPL_1,WV8:XCS:BMMON:AMPL_2,WV8:XCS:BMMON:AMPL_3,WV8:XCS:BMMON:AMPL_4,WV8:XCS:BMMON:AMPL_5,WV8:XCS:BMMON:AMPL_6,WV8:XCS:BMMON:AMPL_7,WV8:XCS:BMMON:AMPL_8,WV8:XCS:BMMON:AMPL_9,WV8:XCS:BMMON:AMPL_10,WV8:XCS:BMMON:AMPL_11,WV8:XCS:BMMON:AMPL_12,WV8:XCS:BMMON:AMPL_13,WV8:XCS:BMMON:AMPL_14,WV8:XCS:BMMON:AMPL_15,WV8:XCS:BMMON:TPOS_0,WV8:XCS:BMMON:TPOS_1,WV8:XCS:BMMON:TPOS_2,WV8:XCS:BMMON:TPOS_3,WV8:XCS:BMMON:TPOS_4,WV8:XCS:BMMON:TPOS_5,WV8:XCS:BMMON:TPOS_6,WV8:XCS:BMMON:TPOS_7,WV8:XCS:BMMON:TPOS_8,WV8:XCS:BMMON:TPOS_9,WV8:XCS:BMMON:TPOS_10,WV8:XCS:BMMON:TPOS_11,WV8:XCS:BMMON:TPOS_12,WV8:XCS:BMMON:TPOS_13,WV8:XCS:BMMON:TPOS_14,WV8:XCS:BMMON:TPOS_15" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

# Configure the WAVE8s.
dbpf WV8:XCS:BMMON:DO_CONFIG.PROC 1

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
