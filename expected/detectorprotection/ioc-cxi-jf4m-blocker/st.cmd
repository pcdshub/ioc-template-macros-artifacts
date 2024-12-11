#!/reg/g/pcds/epics/ioc/common/detectorprotection/R3.0.0/bin/rhel7-x86_64/detprot

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

< envPaths
epicsEnvSet( "IOCNAME",      "ioc-cxi-jf4m-blocker" )
epicsEnvSet( "ENGINEER",     "Kaushik Malapati (kaushikm)" )
epicsEnvSet( "LOCATION",     "CXI:JF4M:BLOCKER" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",	     "IOC:CXI:JF4M:BLOCKER" )
epicsEnvSet( "IOCTOP",	     "/reg/g/pcds/epics/ioc/common/detectorprotection/R3.0.0" )
epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/cxi/detectorprotection/R3.0.0/build" )
cd( "$(IOCTOP)" )

# Register all support components
dbLoadDatabase( "dbd/detprot.dbd" )
detprot_registerRecordDeviceDriver(pdbbase)
#------------------------------------------------------------------------------

# Load record instances
dbLoadRecords( "db/iocSoft.db",             "IOC=IOC:CXI:JF4M:BLOCKER" )
dbLoadRecords( "db/save_restoreStatus.db",  "P=IOC:CXI:JF4M:BLOCKER:" )

# Load detprot records
dbLoadRecords("db/detprot.db", "NAME=CXI:JF4M:BLOCKER,PICKER=CXI:DIA:MMS:16, OPTLINK1=, OPTVAL1=, OPTLINK2=, OPTVAL2=, OPTLINK3=, OPTVAL3=")

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

# Configure access security: this is required for caPutLog.
asSetFilename("$(TOP)/iocBoot/templates/unrestricted.acf")

# Initialize the IOC and start processing records
iocInit()

# caPutLogInit("HOST:PORT", config)
# config options:
#       caPutLogNone       -1: no logging (disable)
#       caPutLogOnChange    0: log only on value change
#       caPutLogAll         1: log all puts
#       caPutLogAllNoFilter 2: log all puts no filtering on same PV
caPutLogInit("${EPICS_CA_PUT_LOG_ADDR}", 0)

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req",  5,  "IOC=$(IOC_PV)" )
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV)" )

# All IOCs should dump some common info after initial startup.
< $(IOC_COMMON)/All/post_linux.cmd
