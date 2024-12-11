#!/reg/g/pcds/epics/ioc/common/qadc/R2.0.10/bin/rhel7-x86_64/qadc134Ioc

epicsEnvSet("IOCNAME", "ioc-xcs-qadc" )
epicsEnvSet("ENGINEER", "Michael Browne (mcbrowne)" )
epicsEnvSet("LOCATION", "unknown" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:XCS:QADC:01")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/qadc/R2.0.10")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/xcs/qadc/R1.0.1/build")
cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES", "20000000")

# Register all support components
dbLoadDatabase("dbd/qadc134Ioc.dbd")
qadc134Ioc_registerRecordDeviceDriver(pdbbase)

Qadc134Register(QADC0, /dev/datadev_0)

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):" )

dbLoadRecords("db/qadc134.db", "BASE=XCS:QADC:01,DEV=QADC0,MODE=0")
dbLoadRecords("db/qadc134_lcls1.db", "BASE=XCS:QADC:01,DEV=QADC0")

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

dbpf XCS:QADC:01:CONFIG 1
dbpf XCS:QADC:01:START 1

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
