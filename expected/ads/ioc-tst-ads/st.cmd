#!/reg/g/pcds/epics/ioc/common/ads/R1.0.0/bin/linux-x86/ads

epicsEnvSet("IOCNAME", "ioc-tst-ads" )
epicsEnvSet("ENGINEER", "Michael Browne (mcbrowne)" )
epicsEnvSet("LOCATION", "Unknown" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:TST:ADS:01")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/ads/R1.0.0")
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/common/ads/R1.0.0/children/build")
cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/ads.dbd")
ads_registerRecordDeviceDriver(pdbbase)

## LOAD STUFF HERE!!!  DRIVERS FIRST, THEN RECORDS!
dbLoadRecords("db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords("db/save_restoreStatus.db", "IOC=$(IOC_PV)")

# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "$(IOCNAME).sav" )
set_pass1_restoreFile( "$(IOCNAME).sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV)" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
