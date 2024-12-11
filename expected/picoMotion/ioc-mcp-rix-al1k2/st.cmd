#!/reg/g/pcds/epics/ioc/common/picoMotion/R4.0.1/bin/rhel7-x86_64/motion

< envPaths
< /reg/d/iocCommon/All/pre_linux.cmd

epicsEnvSet("ENGINEER", "Zachary Lentz (zlentz)")
epicsEnvSet("IOC", "ioc-mcp-rix-al1k2")
epicsEnvSet("IOCSH_PS1", "$(IOC)> ")
epicsEnvSet("EPICS_NAME", "AL1K2:L2SI:MCP:IOC")
epicsEnvSet("IOCTOP","/reg/g/pcds/epics/ioc/common/picoMotion/R4.0.1")
epicsEnvSet("TOP","/reg/g/pcds/epics/ioc/rix/picoMotion/R1.0.0/build")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol" )
epicsEnvSet("IP", "mcp-rix-al1k2")
epicsEnvSet("Port", "P0")
epicsEnvSet("CtrlBase", "M")
epicsEnvSet("PREFIX", "AL1K2:L2SI:MCP")

cd ("$(IOCTOP)")

## Register all support components
dbLoadDatabase("dbd/motion.dbd")
motion_registerRecordDeviceDriver(pdbbase)


# Setup IP port for 8742
drvAsynIPPortConfigure("$(Port)", "$(IP):23 TCP", 0, 0, 0)
asynOctetSetInputEos("$(Port)",0,"\r")
asynOctetSetOutputEos("$(Port)",0,"\r")
asynSetTraceMask("$(Port)",-1,0x1)
asynSetTraceIOMask("$(Port)",-1,0x1)

# New Focus Picomotor Network Controller (model 87xx) configuration parameters:  
#     (1) IP asyn port name (string)
#     (2) Controller asyn port name (string)	
#     (3) Number of axes
#     (4) Moving poll period (ms)
#     (5) Idle poll period (ms)
#     (6) Controller number (starting with 1)

# Load record instances

epicsEnvSet("OPEN_MM","EGU=mm,VELO=.011,VBAS=0.,ACCL=1.5,BDST=0,BVEL=.001,BACC=0.2,MRES=1.5e-5,PREC=3,DHLM=100,DLLM=-100")
dbLoadRecords("db/basic_asyn_motor.db","P=$(PREFIX):,M=01,DTYP='asynMotor',DIR=Pos,INIT='',DESC=TIP,PORT=$(CtrlBase)0,ADDR=0,$(OPEN_MM)")
dbLoadRecords("db/basic_asyn_motor.db","P=$(PREFIX):,M=02,DTYP='asynMotor',DIR=Pos,INIT='',DESC=TILT,PORT=$(CtrlBase)0,ADDR=1,$(OPEN_MM)")
dbLoadRecords("db/basic_asyn_motor.db","P=$(PREFIX):,M=03,DTYP='asynMotor',DIR=Pos,INIT='',DESC=X,PORT=$(CtrlBase)0,ADDR=2,$(OPEN_MM)")
dbLoadRecords("db/basic_asyn_motor.db","P=$(PREFIX):,M=04,DTYP='asynMotor',DIR=Pos,INIT='',DESC=Y,PORT=$(CtrlBase)0,ADDR=3,$(OPEN_MM)")

dbLoadRecords("db/reset8742.db", "IOC=$(EPICS_NAME),PORT=$(Port)")
dbLoadRecords("db/asynRecord.db", "P=$(EPICS_NAME),R=:asyn,PORT=$(Port),ADDR=,IMAX=80,OMAX=80")
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

