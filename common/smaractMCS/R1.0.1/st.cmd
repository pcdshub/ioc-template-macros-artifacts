#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,rhel7-x86_64)/mcs
epicsEnvSet("IOCNAME",    "$$IOCNAME" )
epicsEnvSet("ENGINEER",   "$$ENGINEER")
epicsEnvSet("LOCATION",   "$$LOCATION")
epicsEnvSet("IOCSH_PS1",  "$(IOCNAME)> ")
epicsEnvSet("IOC_PV",     "$$IOC_PV")
epicsEnvSet("IOCTOP",     "$$IOCTOP")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")
< envPaths
epicsEnvSet("TOP", "$$TOP")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/mcs.dbd")
mcs_registerRecordDeviceDriver(pdbbase)

$$LOOP(MCS)
$$IF(PORT)
drvAsynIPPortConfigure("TCP$$INDEX", "$$DEV:$$PORT TCP", 0, 0, 0 )
$$ELSE(PORT)
drvAsynSerialPortConfigure("TCP$$INDEX", "/dev/$$DEV", 0, 0, 0);
$$ENDIF(PORT)
$$IF(DEBUG,,#)asynSetTraceMask(  "TCP$$INDEX",	0,		9)
$$IF(DEBUG,,#)asynSetTraceIOMask("TCP$$INDEX",	0,		2)
$$ENDLOOP(MCS)

$$LOOP(MCS)
asynOctetSetInputEos("TCP$$INDEX",0,"\n")
asynOctetSetOutputEos("TCP$$INDEX",0,"\n")

#     (1) motorPortName
#     (2) ioPortName
#     (3) numAxes
#     (4) movingPollPeriod (s)
#     (5) idlePollPeriod (s)
smarActMCSCreateController(MCS$$INDEX, "TCP$$INDEX", $$COUNT, 0.1, 1)

$$LOOP(COUNT)
smarActMCSCreateAxis(MCS$$INDEX1, $$INDEX, $$INDEX)
$$ENDLOOP(COUNT)
$$ENDLOOP(MCS)

# Load record instances
dbLoadRecords("db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords("db/save_restoreStatus.db", "IOC=$(IOC_PV)")
$$LOOP(MCS)
$$LOOP(COUNT)
dbLoadRecords("db/MCS.db", "BASE=$$BASE,N=$$INDEX,PORT=MCS$$INDEX1")
$$ENDLOOP(COUNT)
dbLoadRecords("db/asynRecord.db", "P=$$BASE,R=:ASYN,PORT=TCP$$INDEX,ADDR=0,OMAX=0,IMAX=0")
$$ENDLOOP(MCS)

# Setup autosave
set_savefile_path("$(IOC_DATA)/$(IOC)/autosave")
set_requestfile_path("$(TOP)/autosave")
save_restoreSet_status_prefix("$(IOC_PV):")
save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)

# Just restore the settings
set_pass0_restoreFile("$$IOCNAME.sav")
set_pass1_restoreFile("$$IOCNAME.sav")

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set("$$IOCNAME.req", 5, "")

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
