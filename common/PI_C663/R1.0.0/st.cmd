#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,rhel7-x86_64)/motion

< envPaths
< /reg/d/iocCommon/All/pre_linux.cmd

epicsEnvSet("ENGINEER", "$$ENGINEER")
epicsEnvSet("IOC", "$$IOCNAME")
epicsEnvSet("IOCSH_PS1", "$(IOC)> ")
epicsEnvSet("EPICS_NAME", "$$IOC_PREFIX")
epicsEnvSet("IOCTOP","$$IOCTOP")
epicsEnvSet("TOP","$$TOP")

cd ("$(IOCTOP)")

## Register all support components
dbLoadDatabase("dbd/motion.dbd")
motion_registerRecordDeviceDriver(pdbbase)

$$LOOP(CONTROLLER)
# Setup asyn port for PI C-663.
drvAsynIPPortConfigure("RAW_$$INDEX", "$$HOST:$$PORT TCP", 0, 0, 0)
asynOctetSetInputEos("RAW_$$INDEX",0,"\r")
asynOctetSetOutputEos("RAW_$$INDEX",0,"\r")
asynSetTraceIOMask("RAW_$$INDEX",-1,2)
asynSetTraceMask("RAW_$$INDEX",-1,$$IF(DEBUG,$$DEBUG,1))

# PI C-663 Configuration
PI_GCS2_CreateController(C663_$$INDEX, RAW_$$INDEX, $$IF(AXES,$$AXES,1), 0, 0, 100, 500)
#     (1) port name
#     (2) asyn port name
#     (3) number of axes
#     (4) priority
#     (5) stacksize
#     (6) moving poll time (msec)
#     (7) idle poll time (msec)
$$ENDLOOP(CONTROLLER)

# Load record instances

epicsEnvSet("CFG","EGU=mm,VELO=2,VBAS=0.1,ACCL=2,BDST=0,BVEL=0.1,BACC=1,MRES=1.95315e-5,PREC=3,DHLM=100,DLLM=-100")
$$LOOP(MOTOR)
dbLoadRecords("db/basic_asyn_motor.db","P=$$PREFIX:,M=$$NAME,DTYP='asyn',PORT=C663_$$CONTROLLERINDEX,ADDR=$$IF(ADDR,$$ADDR,0),DIR=Pos,INIT='',DESC=$$DESC,$(CFG)")
dbLoadRecords("db/extra_motor.db","MOTOR=$$PREFIX:$$NAME")
dbLoadRecords("db/asynRecord.db", "P=$(EPICS_NAME),R=:asyn$$INDEX,PORT=C663_$$CONTROLLERINDEX,ADDR=$$IF(ADDR,$$ADDR,0),IMAX=80,OMAX=80")
$$ENDLOOP(MOTOR)

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

