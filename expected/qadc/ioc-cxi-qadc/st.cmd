#!/cds/group/pcds/epics/ioc/common/qadc/R2.3.0/bin/rhel7-x86_64/qadcIoc

epicsEnvSet("IOCNAME", "ioc-cxi-qadc" )
epicsEnvSet("ENGINEER", "Michael Browne (mcbrowne)" )
epicsEnvSet("LOCATION", "unknown" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:CXI:QADC:01")
epicsEnvSet("IOCTOP", "/cds/group/pcds/epics/ioc/common/qadc/R2.3.0")

< envPaths
epicsEnvSet("TOP", "/cds/group/pcds/epics/ioc/common/qadc/R2.3.0/children/build")
cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES", "20000000")

# Register all support components
dbLoadDatabase("dbd/qadcIoc.dbd")
qadcIoc_registerRecordDeviceDriver(pdbbase)

QadcRegister(QADC0, /dev/datadev_0)

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):" )

dbLoadRecords("db/qadc.db", "BASE=CXI:QADC:01,DEV=QADC0")

# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "$(IOCNAME).sav" )
set_pass1_restoreFile( "$(IOCNAME).sav" )

# Access Security required by caPutLog
asSetFilename("$(IOCTOP)/iocBoot/templates/default.acf")

# Setting the caPutLog file location
caPutLogFile("$(IOC_DATA)/$(IOC)/logs/caPutLog.log")

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV)" )

dbpf CXI:QADC:01:CONFIG.PROC 1
dbpf CXI:QADC:01:START 1

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

# Start caPutLog
# caPutLogInit("HOST:PORT", config)
# config options:
#       caPutLogNone       -1: no logging (disable)
#       caPutLogOnChange    0: log only on value change
#       caPutLogAll         1: log all puts
#       caPutLogAllNoFilter 2: log all puts no filtering on same PV
caPutLogInit("${EPICS_CAPUTLOG_HOST}:${EPICS_CAPUTLOG_PORT}", 0)
