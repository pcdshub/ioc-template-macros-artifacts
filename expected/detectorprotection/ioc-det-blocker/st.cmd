#!/cds/group/pcds/epics/ioc/common/detectorprotection/R1.0.0/bin/rhel7-x86_64/detprot

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

< envPaths
epicsEnvSet( "IOCNAME",      "ioc-det-blocker" )
epicsEnvSet( "ENGINEER",     "Daniel Damiani (ddamiani)" )
epicsEnvSet( "LOCATION",     "DET:FAKE:BLOCKER" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",	     "IOC:DET:FAKE:BLOCKER" )
epicsEnvSet( "IOCTOP",	     "/cds/group/pcds/epics/ioc/common/detectorprotection/R1.0.0" )
epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/det/detectorprotection/R1.0.0/build" )
cd( "$(IOCTOP)" )

# Register all support components
dbLoadDatabase( "dbd/detprot.dbd" )
detprot_registerRecordDeviceDriver(pdbbase)
#------------------------------------------------------------------------------

# Load record instances
dbLoadRecords( "db/iocSoft.db",             "IOC=IOC:DET:FAKE:BLOCKER" )
dbLoadRecords( "db/save_restoreStatus.db",  "P=IOC:DET:FAKE:BLOCKER:" )

# Load detprot records
dbLoadRecords("db/detprot.db", "NAME=DET:CSPAD:BLOCKER,TRIGGER=DET:PROT:TRIGGER,PICKER=DET:PROT:PICKER")
dbLoadRecords("db/detprot.db", "NAME=DET:EPIX:BLOCKER,TRIGGER=DET:PROT:TRIGGER,PICKER=DET:PROT:PICKER")
dbLoadRecords("db/detprot.db", "NAME=DET:JUNGFRAU:BLOCKER,TRIGGER=DET:PROT:TRIGGER,PICKER=DET:PROT:PICKER")

# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOCNAME)/autosave" )
set_requestfile_path( "$(BUILD_TOP)/autosave" )
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
create_monitor_set( "autoSettings.req",  5,  "IOC=$(IOC_PV)" )
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV)" )

# All IOCs should dump some common info after initial startup.
< $(IOC_COMMON)/All/post_linux.cmd