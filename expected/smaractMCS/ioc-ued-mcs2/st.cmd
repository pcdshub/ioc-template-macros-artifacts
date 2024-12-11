#!/reg/g/pcds/epics/ioc/common/smaractMCS/R1.0.1/bin/rhel7-x86_64/mcs
epicsEnvSet("IOCNAME",    "ioc-ued-mcs2" )
epicsEnvSet("ENGINEER",   "Michael Browne (mcbrowne)")
epicsEnvSet("LOCATION",   "UED Bunker")
epicsEnvSet("IOCSH_PS1",  "$(IOCNAME)> ")
epicsEnvSet("IOC_PV",     "IOC:UED:MCS:02")
epicsEnvSet("IOCTOP",     "/reg/g/pcds/epics/ioc/common/smaractMCS/R1.0.1")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/ued/smaractMCS/R1.0.0/build")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/mcs.dbd")
mcs_registerRecordDeviceDriver(pdbbase)

drvAsynIPPortConfigure("TCP0", "moxa-ued-02:4001 TCP", 0, 0, 0 )
#asynSetTraceMask(  "TCP0",	0,		9)
#asynSetTraceIOMask("TCP0",	0,		2)

asynOctetSetInputEos("TCP0",0,"\n")
asynOctetSetOutputEos("TCP0",0,"\n")

#     (1) motorPortName
#     (2) ioPortName
#     (3) numAxes
#     (4) movingPollPeriod (s)
#     (5) idlePollPeriod (s)
smarActMCSCreateController(MCS0, "TCP0", 1, 0.1, 1)

smarActMCSCreateAxis(MCS0, 0, 0)

# Load record instances
dbLoadRecords("db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords("db/save_restoreStatus.db", "IOC=$(IOC_PV)")
dbLoadRecords("db/MCS.db", "BASE=UED:MCS:02,N=0,PORT=MCS0")
dbLoadRecords("db/asynRecord.db", "P=UED:MCS:02,R=:ASYN,PORT=TCP0,ADDR=0,OMAX=0,IMAX=0")

# Setup autosave
set_savefile_path("$(IOC_DATA)/$(IOC)/autosave")
set_requestfile_path("$(TOP)/autosave")
save_restoreSet_status_prefix("$(IOC_PV):")
save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)

# Just restore the settings
set_pass0_restoreFile("ioc-ued-mcs2.sav")
set_pass1_restoreFile("ioc-ued-mcs2.sav")

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set("ioc-ued-mcs2.req", 5, "")

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
