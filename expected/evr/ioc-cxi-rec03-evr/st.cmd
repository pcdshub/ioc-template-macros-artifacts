#!/reg/g/pcds/package/epics/3.14/ioc/common/evr/R1.2.2/bin/rhel7-x86_64/evr

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

< envPaths
epicsEnvSet( "IOCNAME",      "ioc-cxi-rec03-evr" )
epicsEnvSet( "ENGINEER",     "Divya Thanasekaran (divya)" )
epicsEnvSet( "LOCATION",     "BUILDING 999-CXI" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "IOC:CXI:REC:EVR:03" )
epicsEnvSet( "IOCTOP",       "/reg/g/pcds/package/epics/3.14/ioc/common/evr/R1.2.2" )
epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/cxi/evr/R0.1.3/build" )
cd( "$(IOCTOP)" )

# Set Max array size
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "20000000" )

# Setup EVR env vars
epicsEnvSet( "EVR_PV",       "CXI:REC:EVR:03" )
epicsEnvSet( "EVR_CARD",     "0" )
# EVR Type: 0=VME, 1=PMC, 3=CPCI, 15=SLAC
epicsEnvSet( "EVRID_PMC",    "1" )
epicsEnvSet( "EVRID_CPCI",   "3" )
epicsEnvSet( "EVRID_SLAC",   "15" )
epicsEnvSet( "EVRDB_PMC",    "db/evrPmc230.db" )
epicsEnvSet( "EVRDB_CPCI",   "db/evrPmc230.db" )
epicsEnvSet( "EVRDB_SLAC",   "db/evrSLAC.db" )
epicsEnvSet( "EVRID",        "$(EVRID_SLAC)" )
epicsEnvSet( "EVRDB",        "$(EVRDB_SLAC)" )
epicsEnvSet( "EVR_DEBUG",    "0" )

# Register all support components
dbLoadDatabase( "dbd/evr.dbd" )
evr_registerRecordDeviceDriver(pdbbase)

# Configure the EVR
ErDebugLevel( 0 )
ErConfigure( $(EVR_CARD), 0, 0, 0, $(EVRID_SLAC) )
dbLoadRecords( "$(EVRDB)", "TYPE=,IOC=$(IOC_PV),EVR=$(EVR_PV),CARD=$(EVR_CARD)")

# Load soft ioc related record instances
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )

# Setup autosave
dbLoadRecords( "db/save_restoreStatus.db",	"IOC=$(IOC_PV)" )
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(BUILD_TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "autoSettings.sav" )
set_pass1_restoreFile( "$(IOC).sav" )

#
# Initialize the IOC and start processing records
#
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req",  5,  "" )
create_monitor_set( "$(IOCNAME).req",    5,  "" )

# All IOCs should dump some common info after initial startup.
< $(IOC_COMMON)/All/post_linux.cmd

