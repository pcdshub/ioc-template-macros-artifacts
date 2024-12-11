#!$$IOCTOP/bin/rhel7-x86_64/dso4000

epicsEnvSet("IOCNAME",    "$$IOCNAME" )
epicsEnvSet("ENGINEER",   "$$ENGINEER")
epicsEnvSet("LOCATION",   "$$LOCATION")
epicsEnvSet("IOCSH_PS1",  "$(IOCNAME)> ")
epicsEnvSet("IOC_PV",     "$$IOC_PV")
epicsEnvSet("IOCTOP",     "$$IOCTOP")
epicsEnvSet("BASE_NAME",  "$$BASE")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/app/srcProtocol")
< envPaths
epicsEnvSet("TOP", "$$TOP")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/dso4000.dbd")
dso4000_registerRecordDeviceDriver(pdbbase)

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1

# Configure each device
# Found lower performance with socket server, switched to LXI interface
#drvAsynIPPortConfigure("DSO","$$IP:$$IP_PORT",0,0,0)
vxi11Configure("DSO","$$IP",0,"0.0","inst0",0,0)

$$IF(DEBUG)
asynSetTraceMask(  "DSO",	0,		9)
asynSetTraceIOMask("DSO",	0,		2)
$$ENDIF(DEBUG)

# Occaisionally on reboot the IOC is slow to connect to the scope, and some
# records would not initialize properly. Added the small sleep below to help
# alleviate this.
epicsThreadSleep(2.0)

# Load record instances
dbLoadRecords("db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords("db/save_restoreStatus.db", "P=$(IOC_PV):")
#dbLoadRecords("db/save_restoreStatus.db", "IOC=$(IOC_PV)")
#dbLoadRecords("db/dso4000.db", "BASE=$$BASE,PORT=$(BASE_NAME)")

dbLoadRecords("db/dso_common.db", "P=$$BASE,R=,L=DSO,TPRO=$$TPRO")
dbLoadRecords("db/dso_channel.db", "P=$$BASE,R=,L=DSO,C=1,TPRO=$$TPRO")
dbLoadRecords("db/dso_channel.db", "P=$$BASE,R=,L=DSO,C=2,TPRO=$$TPRO")
dbLoadRecords("db/dso_channel.db", "P=$$BASE,R=,L=DSO,C=3,TPRO=$$TPRO")
dbLoadRecords("db/dso_channel.db", "P=$$BASE,R=,L=DSO,C=4,TPRO=$$TPRO")
dbLoadRecords("db/dso_math.db", "P=$$BASE,R=,L=DSO,TPRO=$$TPRO")

dbLoadRecords("db/asynRecord.db", "P=$$BASE,R=:ASYN,PORT=DSO,ADDR=0,OMAX=0,IMAX=0")

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
