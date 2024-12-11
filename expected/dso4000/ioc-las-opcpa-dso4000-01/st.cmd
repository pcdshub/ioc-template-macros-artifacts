#!/cds/group/pcds/epics/ioc/common/dso4000/R1.0.1/bin/rhel7-x86_64/dso4000

epicsEnvSet("IOCNAME",    "ioc-las-opcpa-dso4000-01" )
epicsEnvSet("ENGINEER",   "tjohnson")
epicsEnvSet("LOCATION",   "Fiber Timing Lab")
epicsEnvSet("IOCSH_PS1",  "$(IOCNAME)> ")
epicsEnvSet("IOC_PV",     "IOC:LAS:DSO4000:02")
epicsEnvSet("IOCTOP",     "/cds/group/pcds/epics/ioc/common/dso4000/R1.0.1")
epicsEnvSet("BASE_NAME",  "LAS:DSO4000:02")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/app/srcProtocol")
< envPaths
epicsEnvSet("TOP", "/cds/group/pcds/epics/ioc/las/dso4000/R1.0.2/build")
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
#drvAsynIPPortConfigure("DSO","scope-las-opcpa-01:4000",0,0,0)
vxi11Configure("DSO","scope-las-opcpa-01",0,"0.0","inst0",0,0)


# Occaisionally on reboot the IOC is slow to connect to the scope, and some
# records would not initialize properly. Added the small sleep below to help
# alleviate this.
epicsThreadSleep(2.0)

# Load record instances
dbLoadRecords("db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords("db/save_restoreStatus.db", "P=$(IOC_PV):")
#dbLoadRecords("db/save_restoreStatus.db", "IOC=$(IOC_PV)")
#dbLoadRecords("db/dso4000.db", "BASE=LAS:DSO4000:02,PORT=$(BASE_NAME)")

dbLoadRecords("db/dso_common.db", "P=LAS:DSO4000:02,R=,L=DSO,TPRO=")
dbLoadRecords("db/dso_channel.db", "P=LAS:DSO4000:02,R=,L=DSO,C=1,TPRO=")
dbLoadRecords("db/dso_channel.db", "P=LAS:DSO4000:02,R=,L=DSO,C=2,TPRO=")
dbLoadRecords("db/dso_channel.db", "P=LAS:DSO4000:02,R=,L=DSO,C=3,TPRO=")
dbLoadRecords("db/dso_channel.db", "P=LAS:DSO4000:02,R=,L=DSO,C=4,TPRO=")
dbLoadRecords("db/dso_math.db", "P=LAS:DSO4000:02,R=,L=DSO,TPRO=")

dbLoadRecords("db/asynRecord.db", "P=LAS:DSO4000:02,R=:ASYN,PORT=DSO,ADDR=0,OMAX=0,IMAX=0")

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
