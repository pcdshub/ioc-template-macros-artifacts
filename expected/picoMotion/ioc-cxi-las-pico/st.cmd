#!/reg/g/pcds/package/epics/3.14/ioc/common/picoMotion/R2.1.0/bin/linux-x86/motion


< envPaths
< /reg/d/iocCommon/All/pre_linux.cmd

epicsEnvSet("ENGINEER", "Teddy Rendahl (trendahl)")
epicsEnvSet("IOC", "ioc-cxi-las-pico")
epicsEnvSet("IOCSH_PS1", "$(IOC)> ")
epicsEnvSet("EPICS_NAME", "IOC:CXI:LAS:PICO" )
epicsEnvSet("IOCTOP","/reg/g/pcds/package/epics/3.14/ioc/common/picoMotion/R2.1.0")
epicsEnvSet("TOP","/reg/g/pcds/epics/ioc/cxi/picoMotion/R2.1.3/build")
epicsEnvSet("TYPES_FILE","/reg/g/pcds/package/epics/3.14/ioc/common/picoMotion/R2.1.0/motionApp/Db/TYPES")
#epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/motionApp/srcProtocol")
cd ("$(IOCTOP)")

## Register all support components
dbLoadDatabase("dbd/motion.dbd",0,0)
motion_registerRecordDeviceDriver(pdbbase)

## Load record instances
dbLoadRecords("db/iocAdmin.db", "IOC=$(EPICS_NAME)")
#Load motor Records
epicsEnvSet("OPEN_MM","EGU=mm,VELO=.011,VBAS=0.,ACCL=1.5,BDST=0,BVEL=.001,BACC=0.2,MRES=1.5e-5,PREC=3,DHLM=100,DLLM=-100")

epicsEnvSet("OPEN_MM_2","EGU=mm,VELO=60,VBAS=0.,ACCL=1.5,BDST=0,BVEL=.001,BACC=0.2,MRES=1.5e-5,PREC=4,DHLM=100,DLLM=-100")

epicsEnvSet("OPEN_DEGREES","EGU=degrees,VELO=60,VBAS=0.,ACCL=1.5,BDST=0,BVEL=1,BACC=0.2,MRES=1.5e-3,PREC=3,DHLM=100,DLLM=-100")

epicsEnvSet("CLOSED_LOOP","EGU=um,VELO=25,VBAS=1,ACCL=1.5,BDST=0.005,BVEL=1,BACC=0.2,MRES=.0025,PREC=4,DHLM=100,DLLM=-100")

dbLoadRecords("db/basic_motor.db","C=0,S=0,P=,M=CXI:LAS:PIC:01,DTYP=PMNC87xx,DIR=Pos,INIT='',DESC=PICO_0,$(OPEN_MM)")
dbLoadRecords("db/basic_motor.db","C=0,S=1,P=,M=CXI:LAS:PIC:02,DTYP=PMNC87xx,DIR=Pos,INIT='',DESC=PICO_1,$(OPEN_MM)")
dbLoadRecords("db/basic_motor.db","C=0,S=2,P=,M=CXI:LAS:PIC:03,DTYP=PMNC87xx,DIR=Pos,INIT='',DESC=PICO_2,$(OPEN_MM)")
dbLoadRecords("db/basic_motor.db","C=0,S=3,P=,M=CXI:LAS:PIC:04,DTYP=PMNC87xx,DIR=Pos,INIT='',DESC=PICO_3,$(OPEN_MM)")
dbLoadRecords("db/basic_motor.db","C=0,S=4,P=,M=CXI:LAS:PIC:05,DTYP=PMNC87xx,DIR=Pos,INIT='',DESC=PICO_4,$(OPEN_MM)")
dbLoadRecords("db/basic_motor.db","C=0,S=5,P=,M=CXI:LAS:PIC:06,DTYP=PMNC87xx,DIR=Pos,INIT='',DESC=PICO_5,$(OPEN_MM)")
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

PMNC87xxSetup(1,3, 10) 

# New Focus Picomotor Network Controller (model 87xx) configuration parameters:
#     (1) controller no. being configured, 
#     (2) asyn port name (string)

dbLoadRecords("db/asynRecord.db", "P=mcf-cxi-sc1-2,R=:asyn,PORT=mcf-cxi-sc1-2,ADDR=0,IMAX=0,OMAX=0")
drvAsynIPPortConfigure("mcf-cxi-sc1-2","mcf-cxi-sc1-2:23 TCP",0,0,0)
PMNC87xxConfig(0,"mcf-cxi-sc1-2")

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

