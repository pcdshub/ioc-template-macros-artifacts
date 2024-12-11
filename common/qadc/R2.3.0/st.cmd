#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/qadc$$IF(QADC134NAME0,134,)Ioc

epicsEnvSet("IOCNAME", "$$IOCNAME" )
epicsEnvSet("ENGINEER", "$$ENGINEER" )
epicsEnvSet("LOCATION", "$$LOCATION" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "$$IOC_PV")
epicsEnvSet("IOCTOP", "$$IOCTOP")

< envPaths
epicsEnvSet("TOP", "$$TOP")
cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES", "20000000")

# Register all support components
dbLoadDatabase("dbd/qadc$$IF(QADC134NAME0,134,)Ioc.dbd")
qadc$$IF(QADC134NAME0,134,)Ioc_registerRecordDeviceDriver(pdbbase)

$$LOOP(QADC)
QadcRegister(QADC$$INDEX, $$DEVICE)
$$ENDLOOP(QADC)
$$LOOP(QADC134)
Qadc134Register(QADC$$INDEX, $$DEVICE)
$$ENDLOOP(QADC134)

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):" )

$$LOOP(QADC)
dbLoadRecords("db/qadc.db", "BASE=$$NAME,DEV=QADC$$INDEX")
$$ENDLOOP(QADC)
$$LOOP(QADC134)
dbLoadRecords("db/qadc134.db", "BASE=$$NAME,DEV=QADC$$INDEX,MODE=$$IF(LCLS2,1,0)")
$$IF(LCLS2)
dbLoadRecords("db/qadc134_lcls2.db", "BASE=$$NAME,DEV=QADC$$INDEX")
$$ELSE(LCLS2)
dbLoadRecords("db/qadc134_lcls1.db", "BASE=$$NAME,DEV=QADC$$INDEX")
$$ENDIF(LCLS2)
$$ENDLOOP(QADC134)

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

$$LOOP(QADC)
dbpf $$NAME:CONFIG.PROC 1
dbpf $$NAME:START 1
$$ENDLOOP(QADC)
$$LOOP(QADC134)
dbpf $$NAME:CONFIG 1
dbpf $$NAME:START 1
$$ENDLOOP(QADC134)

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
