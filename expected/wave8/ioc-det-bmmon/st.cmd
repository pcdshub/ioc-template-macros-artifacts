#!/cds/group/pcds/epics/ioc/common/wave8/R3.0.0/bin/rhel7-x86_64/wave8Ioc

epicsEnvSet("IOCNAME", "ioc-det-bmmon" )
epicsEnvSet("ENGINEER", "Daniel Damiani (ddamiani)" )
epicsEnvSet("LOCATION", "NEH Det Lab" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:DET:BMMON")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet("IOCTOP", "/cds/group/pcds/epics/ioc/common/wave8/R3.0.0")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/det/wave8/R3.0.0/build")
cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES", "10000000")

# Register all support components
dbLoadDatabase("dbd/wave8Ioc.dbd")
wave8Ioc_registerRecordDeviceDriver(pdbbase)

ErDebugLevel( 0 )

# Initialize EVR
ErConfigure( 0, 0, 0, 0, $(EVRID_PMC) )

# Load EVR record instances
dbLoadRecords( $(EVRDB_PMC), "IOC=IOC:DET:BMMON,EVR=EVR:DET:BMMON,CARD=0,IP0E=Enabled,IP1E=Enabled,IP2E=Enabled" )

PgpRegister(PGP0, 0x40, 0x3, 0)

Wave8Register(WV8:DET:BMMON, PGP0, EVR:DET:BMMON, 0x0, 255)

Wave8Auto 0

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):" )

dbLoadRecords("db/wave8.db", "IOCNAME=ioc-det-bmmon,IOC=$(IOC_PV),BASE=WV8:DET:BMMON,BOX=PGP0,EVR=EVR:DET:BMMON,TRIG=0")
dbLoadRecords("db/evralias.db", "WAVE8=WV8:DET:BMMON,EVR=EVR:DET:BMMON,CH=0")

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

# Configure the WAVE8s.
dbpf WV8:DET:BMMON:DO_CONFIG.PROC 1

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
