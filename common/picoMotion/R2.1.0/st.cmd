#!$$IOCTOP/bin/linux-x86/motion


< envPaths
< /reg/d/iocCommon/All/pre_linux.cmd

epicsEnvSet("ENGINEER", "$$ENGINEER")
epicsEnvSet("IOC", "$$IOCNAME")
epicsEnvSet("IOCSH_PS1", "$(IOC)> ")
epicsEnvSet("EPICS_NAME", "$$TRANSLATE(IOCNAME,"a-z_-","A-Z::")" )
epicsEnvSet("IOCTOP","$$IOCTOP")
epicsEnvSet("TOP","$$TOP")
epicsEnvSet("TYPES_FILE","$$IOCTOP/motionApp/Db/TYPES")
#epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/motionApp/srcProtocol")
cd ("$(IOCTOP)")

## Register all support components
dbLoadDatabase("dbd/motion.dbd",0,0)
motion_registerRecordDeviceDriver(pdbbase)

## Load record instances
dbLoadRecords("db/iocAdmin.db", "IOC=$(EPICS_NAME)")
#Load motor Records
$$INCLUDE($$IOCTOP/motionApp/Db/TYPES)

$$LOOP(PICO_MOTOR)
dbLoadRecords("db/basic_motor.db","C=$$CTRL_NO,S=$$SLOT,P=,M=$$NAME,DTYP=PMNC87xx,DIR=Pos,INIT='',DESC=$$IF(DESC,$$DESC,PICO_$$INDEX),$($$TYPE)")
$$ENDLOOP(PICO_MOTOR)
#these are for 'asyn' debugging


## Set this to see messages from mySub
#var mySubDebug 1

# uncomment these to get asyn tracing.
# asynSetTraceIOMask(1) and asynSetTraceMask(8) gives pico commands in ASCII.
#
#/* traceMask definitions*/
#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010

#/* traceIO mask definitions*/
#define ASYN_TRACEIO_NODATA 0x0000
#define ASYN_TRACEIO_ASCII  0x0001
#define ASYN_TRACEIO_ESCAPE 0x0002
#define ASYN_TRACEIO_HEX    0x0004


# New Focus Picomotor Network Controller (model 87xx) (setup parameters:  
#     (1) maximum number of controllers in system 
#     (2) maximum number of drivers per controller (1 - 3)  
#     (3) motor task polling rate (min=1Hz,max=60Hz)  
#drvPMNC87xxdebug=3

PMNC87xxSetup($$COUNT(CONTROLLER),3, $$IF(POLL_RATE, $$POLL_RATE,10)) 

# New Focus Picomotor Network Controller (model 87xx) configuration parameters:
#     (1) controller no. being configured, 
#     (2) asyn port name (string)

$$LOOP(CONTROLLER)
dbLoadRecords("db/asynRecord.db", "P=$$IP,R=:asyn,PORT=$$IP,ADDR=0,IMAX=0,OMAX=0")
drvAsynIPPortConfigure("$$IP","$$IP:23 TCP",0,0,0)
PMNC87xxConfig($$CTRL_NO,"$$IP")
$$ENDLOOP(CONTROLLER)

# configure TCP port for CampMon motor status communication
####### Autosave #############

save_restoreSet_status_prefix("$(EPICS_NAME):")
save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)

set_savefile_path("$(IOC_DATA)/$(IOC)/autosave")
set_requestfile_path("$(TOP)/autosave")

set_pass0_restoreFile("$(IOC).sav")

save_restoreSet_NumSeqFiles(5)
save_restoreSet_SeqPeriodInSeconds(30)

dbLoadRecords("db/save_restoreStatus.db", "IOC=$(EPICS_NAME)")

# kick off IOC.
iocInit()

# iocLogInit()

######################################################################

create_monitor_set("$(IOC).req", 30, "")

< /reg/d/iocCommon/All/post_linux.cmd

