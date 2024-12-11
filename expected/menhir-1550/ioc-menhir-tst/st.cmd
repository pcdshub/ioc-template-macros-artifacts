#!/cds/group/pcds/epics/ioc/common/menhir-1550/R1.0.2/bin/rhel7-x86_64/menhir

epicsEnvSet("IOCNAME",    "ioc-menhir-tst" )
epicsEnvSet("ENGINEER",   "Jose E. Ortiz")
epicsEnvSet("LOCATION",   "Example Config")
epicsEnvSet("IOCSH_PS1",  "$(IOCNAME)> ")
epicsEnvSet("IOC_PV",     "IOC:MENHIR:TST:01")
epicsEnvSet("IOCTOP",     "/cds/group/pcds/epics/ioc/common/menhir-1550/R1.0.2")
epicsEnvSet("BASE_NAME",  "MENHIR:TST:01")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/app/srcProtocol")
< envPaths
epicsEnvSet("TOP", "/cds/group/pcds/epics/ioc/common/menhir-1550/R1.0.2/children/build")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/menhir.dbd")
menhir_registerRecordDeviceDriver(pdbbase)

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1

# Configure each device
drvAsynIPPortConfigure("$(BASE_NAME)","moxa-las-ftl-01:4016",0,0,0)



# Load record instances
dbLoadRecords("db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords("db/save_restoreStatus.db", "P=$(IOC_PV)")
dbLoadRecords("db/menhir.db", "BASE=MENHIR:TST:01,PORT=$(BASE_NAME)")
dbLoadRecords("db/asynRecord.db", "P=MENHIR:TST:01,R=:ASYN,PORT=$(BASE_NAME),ADDR=0,OMAX=0,IMAX=0")

# Setup autosave
set_savefile_path("$(IOC_DATA)/$(IOC)/autosave")
set_requestfile_path("$(TOP)/autosave")
save_restoreSet_status_prefix("$(IOC_PV):")
save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)

# Just restore the settings
set_pass0_restoreFile("$(IOC).sav")
set_pass1_restoreFile("$(IOC).sav")

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set("$(IOC).req", 5, "")

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
