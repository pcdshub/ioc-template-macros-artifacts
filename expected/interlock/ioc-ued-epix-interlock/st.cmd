#!/reg/g/pcds/epics/ioc/common/interlock/R1.0.0/bin/rhel7-x86_64/interlock

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/ued/interlock/R3.0.0/build" )
< envPaths
epicsEnvSet( "IOCNAME",      "ioc-ued-epix-interlock" )
epicsEnvSet( "ENGINEER",     "Kaushik Malapati (kaushikm)" )
epicsEnvSet( "LOCATION",     "UED:EPIX2M" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "IOC:UED:EPIX2M:01:IL" )
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
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:01, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:02, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:03, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:04, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:05, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:06, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:07, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:08, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:09, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:10, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:11, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:12, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:13, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:14, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:15, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:16, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:17, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:18, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:19, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:20, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:21, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:22, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:23, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:24, DESC=" )
dbLoadRecords( "db/interlock.db", "BASE=UED:EPIX2M:01:INTERLOCK:25, DESC=" )

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
asSetFilename("$(BUILD_TOP)/../restricted.acf")

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
