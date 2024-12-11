#!/reg/g/pcds/epics/ioc/common/picoMotion/R4.0.2/bin/rhel7-x86_64/motion

< envPaths
< /reg/d/iocCommon/All/pre_linux.cmd

epicsEnvSet("ENGINEER", "")
epicsEnvSet("IOC", "ioc-cxi-usr-pico")
epicsEnvSet("IOCSH_PS1", "$(IOC)> ")
epicsEnvSet("EPICS_NAME", "IOC:CXI:USR:PIC")
epicsEnvSet("IOCTOP","/reg/g/pcds/epics/ioc/common/picoMotion/R4.0.2")
epicsEnvSet("TOP","/reg/g/pcds/epics/ioc/common/picoMotion/R4.0.2/children/build")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol" )
epicsEnvSet("CtrlBase", "M")
epicsEnvSet("PREFIX", "CXI:USR:PIC")

cd ("$(IOCTOP)")

## Register all support components
dbLoadDatabase("dbd/motion.dbd")
motion_registerRecordDeviceDriver(pdbbase)


# New Focus Picomotor Network Controller (model 87xx) (setup parameters:  
#     (1) maximum number of controllers in system 
#     (2) maximum number of drivers per controller (1 - 3)  
#     (3) motor task polling rate (min=1Hz,max=60Hz)  
#drvPMNC87xxdebug=3

PMNC87xxSetup(1,3, 10) 

# Setup IP port for 8753
drvAsynIPPortConfigure("P0", "mcf-cxi-usr1:23 TCP", 0, 0, 0)
asynOctetSetInputEos("P0",0,"\r")
asynOctetSetOutputEos("P0",0,"\r")
asynSetTraceMask("P0",-1,0x1)
asynSetTraceIOMask("P0",-1,0x1)

dbLoadRecords("db/asynRecord.db", "P=$(EPICS_NAME):C0,R=:asyn,PORT=P0,ADDR=,IMAX=80,OMAX=80")
PMNC87xxConfig(0,"P0")

# Load record instances

epicsEnvSet("OPEN_MM","EGU=mm,VELO=.011,VBAS=0.,ACCL=1.5,BDST=0,BVEL=.001,BACC=0.2,MRES=1.5e-5,PREC=3,DHLM=100,DLLM=-100")

epicsEnvSet("OPEN_MM_2","EGU=mm,VELO=60,VBAS=0.,ACCL=1.5,BDST=0,BVEL=.001,BACC=0.2,MRES=1.5e-5,PREC=4,DHLM=100,DLLM=-100")

epicsEnvSet("OPEN_DEGREES","EGU=degrees,VELO=60,VBAS=0.,ACCL=1.5,BDST=0,BVEL=1,BACC=0.2,MRES=1.5e-3,PREC=3,DHLM=100,DLLM=-100")

epicsEnvSet("CLOSED_LOOP","EGU=um,VELO=25,VBAS=1,ACCL=1.5,BDST=0.005,BVEL=1,BACC=0.2,MRES=.0025,PREC=4,DHLM=100,DLLM=-100")

dbLoadRecords("db/basic_motor.db","C=0,S=0,P=$(PREFIX):,M=01,DTYP=PMNC87xx,DIR=Pos,INIT='',DESC=01,$(OPEN_MM)")

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

