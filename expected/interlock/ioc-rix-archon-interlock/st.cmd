#!/reg/g/pcds/epics/ioc/common/interlock/R1.0.0/bin/rhel7-x86_64/interlock

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/common/interlock/R1.0.0/children/build" )
< envPaths
epicsEnvSet( "IOCNAME",      "ioc-rix-archon-interlock" )
epicsEnvSet( "ENGINEER",     "Patrick Oppermann (opperman)" )
epicsEnvSet( "LOCATION",     "Location" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "IOC:ILK:QRIXS:DET" )
epicsEnvSet( "IOCTOP",       "/reg/g/pcds/epics/ioc/common/interlock/R1.0.0" )
epicsEnvSet( "EPICS_PVA_AUTO_ADDR_LIST",         "TRUE" )
epicsEnvSet( "EPICS_PVAS_AUTO_BEACON_ADDR_LIST", "TRUE" )
cd( "$(IOCTOP)" )

# Register all support components
dbLoadDatabase("dbd/interlock.dbd")
interlock_registerRecordDeviceDriver(pdbbase)

# Bump up queue sizes!
scanOnceSetQueueSize(4000)
callbackSetQueueSize(4000)

# Load record instances
dbLoadRecords( "db/interlock.db", "BASE=, DESC=Chamber Vacuum" )

dbLoadRecords( "db/iocSoft.db",            "IOC=$(IOC_PV)" )
dbLoadRecords( "db/iocRelease.db",         "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):" )

# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave")
set_requestfile_path( "$(BUILD_TOP)/autosave")
save_restoreSet_status_prefix( "$(IOC_PV)" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

# Just restore the settings
set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "$(IOC).sav" )

# Configure access security: this is required for caPutLog.
asSetFilename("$(IOCTOP)/iocBoot/templates/unrestricted.acf")

# Initialize the IOC and start processing records
iocInit()

# caPutLogInit("HOST:PORT", config)
# config options:
#       caPutLogNone       -1: no logging (disable)
#       caPutLogOnChange    0: log only on value change
#       caPutLogAll         1: log all puts
#       caPutLogAllNoFilter 2: log all puts no filtering on same PV
caPutLogInit("${EPICS_CA_PUT_LOG_ADDR}", 0)

# Start autosave backups
create_monitor_set( "$(IOC).req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
