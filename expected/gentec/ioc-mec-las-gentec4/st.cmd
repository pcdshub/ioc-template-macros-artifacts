#!/reg/g/pcds/epics/ioc/common/gentec/R1.1.1/bin/linux-x86_64/gentec

epicsEnvSet("IOCNAME",    "ioc-mec-las-gentec4" )
epicsEnvSet("ENGINEER",   "Sameen Yunus (sfsyunus)")
epicsEnvSet("LOCATION",   "MEC LPL Enclosure")
epicsEnvSet("IOCSH_PS1",  "$(IOCNAME)> ")
epicsEnvSet("IOC_PV",     "IOC:MEC:LAS:GENTEC:04")
epicsEnvSet("IOCTOP",     "/reg/g/pcds/epics/ioc/common/gentec/R1.1.1")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/app/srcProtocol")
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/mec/gentec/R1.1.2/build")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/gentec.dbd")
gentec_registerRecordDeviceDriver(pdbbase)

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1

# Configure each device
drvAsynIPPortConfigure("GT0","gentec-mec-las-meter4:10001",0,0,0)



# Load record instances
dbLoadRecords("db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords("db/save_restoreStatus.db", "IOC=$(IOC_PV)")
dbLoadRecords("db/gentec.db", "BASE=MEC:LAS:GENTEC:04,PORT=GT0")
dbLoadRecords("db/asynRecord.db", "P=MEC:LAS:GENTEC:04,R=:ASYN,PORT=GT0,ADDR=0,OMAX=0,IMAX=0")

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
