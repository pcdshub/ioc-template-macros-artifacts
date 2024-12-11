#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,rhel7-x86_64)/motion

< envPaths
< /reg/d/iocCommon/All/pre_linux.cmd

epicsEnvSet("ENGINEER", "$$ENGINEER")
epicsEnvSet("IOC", "$$IOCNAME")
epicsEnvSet("IOCSH_PS1", "$(IOC)> ")
epicsEnvSet("EPICS_NAME", "$$IOC_PREFIX")
epicsEnvSet("IOCTOP","$$IOCTOP")
epicsEnvSet("TOP","$$TOP")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol" )
epicsEnvSet("IP", "$$IP")
epicsEnvSet("Port", "P0")
epicsEnvSet("CtrlBase", "M")
epicsEnvSet("PREFIX", "$$PREFIX")

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
$$LOOP(STACK)
Pico8742CreateController("$(CtrlBase)$$INDEX", "$(Port)", 4, 200, 1000, $$CALC{$$INDEX+1})
$$ENDLOOP(STACK)

# Load record instances

epicsEnvSet("OPEN_MM","EGU=mm,VELO=.011,VBAS=0.,ACCL=1.5,BDST=0,BVEL=.001,BACC=0.2,MRES=1.5e-5,PREC=3,DHLM=100,DLLM=-100")
$$LOOP(MOTOR)
dbLoadRecords("db/basic_asyn_motor.db","P=$(PREFIX):,M=$$NAME,DTYP='asynMotor',DIR=Pos,INIT='',DESC=$$DESC,PORT=$(CtrlBase)$$IF(ADDR)$$CALC{(ADDR-1)/4}$$ELSE(ADDR)$$CALC{INDEX/4}$$ENDIF(ADDR),ADDR=$$IF(ADDR)$$CALC{(ADDR-1)%4}$$ELSE(ADDR)$$CALC{INDEX%4}$$ENDIF(ADDR),$(OPEN_MM)")
$$ENDLOOP(MOTOR)

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

