#!/reg/g/pcds/epics/ioc/common/PI_C663/R1.0.0/bin/rhel7-x86_64/motion

< envPaths
< /reg/d/iocCommon/All/pre_linux.cmd

epicsEnvSet("ENGINEER", "Michael Browne (mcbrowne)")
epicsEnvSet("IOC", "ioc-ued-vt50")
epicsEnvSet("IOCSH_PS1", "$(IOC)> ")
epicsEnvSet("EPICS_NAME", "IOC:UED:VT50:01")
epicsEnvSet("IOCTOP","/reg/g/pcds/epics/ioc/common/PI_C663/R1.0.0")
epicsEnvSet("TOP","/reg/g/pcds/epics/ioc/common/PI_C663/R1.0.0/children/build")

cd ("$(IOCTOP)")

## Register all support components
dbLoadDatabase("dbd/motion.dbd")
motion_registerRecordDeviceDriver(pdbbase)

# Setup asyn port for PI C-663.
drvAsynIPPortConfigure("RAW_0", "moxa-ued-02:4004 TCP", 0, 0, 0)
asynOctetSetInputEos("RAW_0",0,"\r")
asynOctetSetOutputEos("RAW_0",0,"\r")
asynSetTraceIOMask("RAW_0",-1,2)
asynSetTraceMask("RAW_0",-1,1)

# PI C-663 Configuration
PI_GCS2_CreateController(C663_0, RAW_0, 1, 0, 0, 100, 500)
#     (1) port name
#     (2) asyn port name
#     (3) number of axes
#     (4) priority
#     (5) stacksize
#     (6) moving poll time (msec)
#     (7) idle poll time (msec)

# Load record instances

epicsEnvSet("CFG","EGU=mm,VELO=2,VBAS=0.1,ACCL=2,BDST=0,BVEL=0.1,BACC=1,MRES=1.95315e-5,PREC=3,DHLM=100,DLLM=-100")
dbLoadRecords("db/basic_asyn_motor.db","P=UED:VT50:,M=01,DTYP='asyn',PORT=C663_0,ADDR=0,DIR=Pos,INIT='',DESC=VT-50,$(CFG)")
dbLoadRecords("db/extra_motor.db","MOTOR=UED:VT50:01")
dbLoadRecords("db/asynRecord.db", "P=$(EPICS_NAME),R=:asyn0,PORT=C663_0,ADDR=0,IMAX=80,OMAX=80")

dbLoadRecords("db/iocSoft.db", "IOC=$(EPICS_NAME)")

set_savefile_path("$(IOC_DATA)/$(IOC)/autosave")
set_requestfile_path("$(TOP)/autosave")
save_restoreSet_status_prefix("$(EPICS_NAME):")
save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)

set_pass0_restoreFile("$(IOC).sav")

save_restoreSet_NumSeqFiles(5)
save_restoreSet_SeqPeriodInSeconds(30)

dbLoadRecords("db/save_restoreStatus.db", "IOC=$(EPICS_NAME)")

# kick off IOC.
iocInit()


######################################################################
create_monitor_set("$(IOC).req", 5, "")

< /reg/d/iocCommon/All/post_linux.cmd

