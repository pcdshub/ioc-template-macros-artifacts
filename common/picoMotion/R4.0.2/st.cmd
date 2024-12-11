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
epicsEnvSet("CtrlBase", "M")
epicsEnvSet("PREFIX", "$$PREFIX")

cd ("$(IOCTOP)")

## Register all support components
dbLoadDatabase("dbd/motion.dbd")
motion_registerRecordDeviceDriver(pdbbase)

$$IF(IP)
# New Focus Picomotor Network Controller (model 87xx) configuration parameters:  
#     (1) IP asyn port name (string)
#     (2) Controller asyn port name (string)	
#     (3) Number of axes
#     (4) Moving poll period (ms)
#     (5) Idle poll period (ms)
#     (6) Controller number (starting with 1)

# Setup IP port for 8742
drvAsynIPPortConfigure("P0", "$$IP:23 TCP", 0, 0, 0)
asynOctetSetInputEos("P0",0,"\r")
asynOctetSetOutputEos("P0",0,"\r")
asynSetTraceMask("P0",-1,0x1)
asynSetTraceIOMask("P0",-1,0x1)
dbLoadRecords("db/asynRecord.db", "P=$(EPICS_NAME):C0,R=:asyn,PORT=P$$INDEX,ADDR=,IMAX=80,OMAX=80")

$$LOOP(STACK)
Pico8742CreateController("$(CtrlBase)$$INDEX", "P0", 4, 200, 1000, $$CALC{$$INDEX+1})
$$ENDLOOP(STACK)
$$ELSE(IP)

# New Focus Picomotor Network Controller (model 87xx) (setup parameters:  
#     (1) maximum number of controllers in system 
#     (2) maximum number of drivers per controller (1 - 3)  
#     (3) motor task polling rate (min=1Hz,max=60Hz)  
#drvPMNC87xxdebug=3

PMNC87xxSetup($$COUNT(CONTROLLER),3, $$IF(POLL_RATE,$$POLL_RATE,10)) 

$$LOOP(CONTROLLER)
# Setup IP port for 8753
drvAsynIPPortConfigure("P$$INDEX", "$$IP:23 TCP", 0, 0, 0)
asynOctetSetInputEos("P$$INDEX",0,"\r")
asynOctetSetOutputEos("P$$INDEX",0,"\r")
asynSetTraceMask("P$$INDEX",-1,0x1)
asynSetTraceIOMask("P$$INDEX",-1,0x1)

dbLoadRecords("db/asynRecord.db", "P=$(EPICS_NAME):C$$INDEX,R=:asyn,PORT=P$$INDEX,ADDR=,IMAX=80,OMAX=80")
PMNC87xxConfig($$INDEX,"P$$INDEX")
$$ENDLOOP(CONTROLLER)
$$ENDIF(IP)

# Load record instances

$$INCLUDE($$IOCTOP/motionApp/Db/TYPES)

$$LOOP(MOTOR)
$$IF(IP)
dbLoadRecords("db/basic_asyn_motor.db","P=$(PREFIX):,M=$$NAME,DTYP='asynMotor',DIR=Pos,INIT='',DESC=$$DESC,PORT=$(CtrlBase)$$IF(ADDR)$$CALC{(ADDR-1)/4}$$ELSE(ADDR)$$CALC{INDEX/4}$$ENDIF(ADDR),ADDR=$$IF(ADDR)$$CALC{(ADDR-1)%4}$$ELSE(ADDR)$$CALC{INDEX%4}$$ENDIF(ADDR),$$IF(TYPE)$($$TYPE)$$ELSE(TYPE)$(OPEN_MM)$$ENDIF(TYPE)")
$$ELSE(IP)
dbLoadRecords("db/basic_motor.db","C=$$IF(ADDR)$$CALC{(ADDR-1)/3}$$ELSE(ADDR)$$CALC{INDEX/3}$$ENDIF(ADDR),S=$$IF(ADDR)$$CALC{(ADDR-1)%3}$$ELSE(ADDR)$$CALC{INDEX%3}$$ENDIF(ADDR),P=$(PREFIX):,M=$$NAME,DTYP=PMNC87xx,DIR=Pos,INIT='',DESC=$$IF(DESC,$$DESC,PICO_$$INDEX),$$IF(TYPE)$($$TYPE)$$ELSE(TYPE)$(OPEN_MM)$$ENDIF(TYPE)")
$$ENDIF(IP)
$$ENDLOOP(MOTOR)

$$IF(IP)
dbLoadRecords("db/reset8742.db", "IOC=$(EPICS_NAME),PORT=P0")
$$ENDIF(IP)
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

