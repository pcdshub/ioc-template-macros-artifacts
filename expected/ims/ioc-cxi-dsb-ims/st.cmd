#!/reg/g/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:CXI:DSB:IMS" )
epicsEnvSet( "LOCATION",             "CXI:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-cxi-dsb-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Divya Thanasekaran (divya)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME),P=$(EPICS_NAME):" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )










dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DSB:MMS:26,PORT=moxa-cxi-02:4006,ASYN=CXI:DSB:MMS:26,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DSB:ATT:2560UM,STATE=IN,SET=3.7695,DELTA=2.0,MOVER=CXI:DSB:MMS:26.VAL,RBV=CXI:DSB:MMS:26.RBV,DMOV=CXI:DSB:MMS:26.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DSB:ATT:2560UM,STATE=OUT,SET=-23.1,DELTA=2.0,MOVER=CXI:DSB:MMS:26.VAL,RBV=CXI:DSB:MMS:26.RBV,DMOV=CXI:DSB:MMS:26.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=CXI:DSB:ATT:2560UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DSB:MMS:26,ALIAS=CXI:DSB:ATT:2560UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DSB:MMS:25,PORT=moxa-cxi-02:4005,ASYN=CXI:DSB:MMS:25,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DSB:ATT:80UM,STATE=IN,SET=0.0371,DELTA=2.0,MOVER=CXI:DSB:MMS:25.VAL,RBV=CXI:DSB:MMS:25.RBV,DMOV=CXI:DSB:MMS:25.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DSB:ATT:80UM,STATE=OUT,SET=-23.1,DELTA=2.0,MOVER=CXI:DSB:MMS:25.VAL,RBV=CXI:DSB:MMS:25.RBV,DMOV=CXI:DSB:MMS:25.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=CXI:DSB:ATT:80UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DSB:MMS:25,ALIAS=CXI:DSB:ATT:80UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DSB:MMS:24,PORT=moxa-cxi-02:4004,ASYN=CXI:DSB:MMS:24,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DSB:ATT:160UM,STATE=IN,SET=17.0,DELTA=2.0,MOVER=CXI:DSB:MMS:24.VAL,RBV=CXI:DSB:MMS:24.RBV,DMOV=CXI:DSB:MMS:24.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DSB:ATT:160UM,STATE=OUT,SET=-8.0,DELTA=2.0,MOVER=CXI:DSB:MMS:24.VAL,RBV=CXI:DSB:MMS:24.RBV,DMOV=CXI:DSB:MMS:24.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=CXI:DSB:ATT:160UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DSB:MMS:24,ALIAS=CXI:DSB:ATT:160UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DSB:MMS:23,PORT=moxa-cxi-02:4003,ASYN=CXI:DSB:MMS:23,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DSB:ATT:320UM,STATE=IN,SET=0.0449,DELTA=2.0,MOVER=CXI:DSB:MMS:23.VAL,RBV=CXI:DSB:MMS:23.RBV,DMOV=CXI:DSB:MMS:23.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DSB:ATT:320UM,STATE=OUT,SET=-23.1,DELTA=2.0,MOVER=CXI:DSB:MMS:23.VAL,RBV=CXI:DSB:MMS:23.RBV,DMOV=CXI:DSB:MMS:23.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=CXI:DSB:ATT:320UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DSB:MMS:23,ALIAS=CXI:DSB:ATT:320UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DSB:MMS:22,PORT=moxa-cxi-02:4002,ASYN=CXI:DSB:MMS:22,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DSB:ATT:640UM,STATE=IN,SET=0.1216,DELTA=2.0,MOVER=CXI:DSB:MMS:22.VAL,RBV=CXI:DSB:MMS:22.RBV,DMOV=CXI:DSB:MMS:22.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DSB:ATT:640UM,STATE=OUT,SET=-23.1,DELTA=2.0,MOVER=CXI:DSB:MMS:22.VAL,RBV=CXI:DSB:MMS:22.RBV,DMOV=CXI:DSB:MMS:22.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=CXI:DSB:ATT:640UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DSB:MMS:22,ALIAS=CXI:DSB:ATT:640UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DSB:MMS:21,PORT=moxa-cxi-02:4001,ASYN=CXI:DSB:MMS:21,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DSB:ATT:1280UM,STATE=IN,SET=-0.0005,DELTA=2.0,MOVER=CXI:DSB:MMS:21.VAL,RBV=CXI:DSB:MMS:21.RBV,DMOV=CXI:DSB:MMS:21.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DSB:ATT:1280UM,STATE=OUT,SET=-23.0,DELTA=2.0,MOVER=CXI:DSB:MMS:21.VAL,RBV=CXI:DSB:MMS:21.RBV,DMOV=CXI:DSB:MMS:21.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=CXI:DSB:ATT:1280UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DSB:MMS:21,ALIAS=CXI:DSB:ATT:1280UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DSB:MMS:27,PORT=moxa-cxi-02:4007,ASYN=CXI:DSB:MMS:27,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:PP,STATE=IN,SET=25,DELTA=0.5,MOVER=CXI:DSB:MMS:27.VAL,RBV=CXI:DSB:MMS:27.RBV,DMOV=CXI:DSB:MMS:27.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:PP,STATE=OUT,SET=0,DELTA=5.0,MOVER=CXI:DSB:MMS:27.VAL,RBV=CXI:DSB:MMS:27.RBV,DMOV=CXI:DSB:MMS:27.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XRT:DIA:PP,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DSB:MMS:27,ALIAS=XRT:DIA:PP:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DSB:MMS:12,PORT=moxa-cxi-04:4012,ASYN=CXI:DSB:MMS:12,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DSB:MMS:13,PORT=moxa-cxi-04:4013,ASYN=CXI:DSB:MMS:13,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )


dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DSB:MMS:13:STATES,STATE=DIODE_LASER,SET=0.5,DELTA=1,MOVER=CXI:DSB:MMS:13.VAL,RBV=CXI:DSB:MMS:13.RBV,DMOV=CXI:DSB:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DSB:MMS:13:STATES,STATE=DIODE_XRAY,SET=6.5,DELTA=1,MOVER=CXI:DSB:MMS:13.VAL,RBV=CXI:DSB:MMS:13.RBV,DMOV=CXI:DSB:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DSB:MMS:13:STATES,STATE=MIRROR,SET=8.51,DELTA=1,MOVER=CXI:DSB:MMS:13.VAL,RBV=CXI:DSB:MMS:13.RBV,DMOV=CXI:DSB:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DSB:MMS:13:STATES,STATE=CLEAR_YAG,SET=18.0,DELTA=1.0,MOVER=CXI:DSB:MMS:13.VAL,RBV=CXI:DSB:MMS:13.RBV,DMOV=CXI:DSB:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DSB:MMS:13:STATES,STATE=FROSTED_YAG,SET=28.0,DELTA=1.0,MOVER=CXI:DSB:MMS:13.VAL,RBV=CXI:DSB:MMS:13.RBV,DMOV=CXI:DSB:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DSB:MMS:13:STATES,STATE=SiN,SET=40.0,DELTA=1.0,MOVER=CXI:DSB:MMS:13.VAL,RBV=CXI:DSB:MMS:13.RBV,DMOV=CXI:DSB:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DSB:MMS:13:STATES,STATE=OUT,SET=100.0,DELTA=5.0 ,MOVER=CXI:DSB:MMS:13.VAL,RBV=CXI:DSB:MMS:13.RBV,DMOV=CXI:DSB:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_7states.db", "DEVICE=CXI:DSB:MMS:13:STATES,STATE1=DIODE_LASER,SEVR1=NO_ALARM,STATE2=DIODE_XRAY,SEVR2=NO_ALARM,STATE3=MIRROR,SEVR3=NO_ALARM,STATE4=CLEAR_YAG,SEVR4=NO_ALARM,STATE5=FROSTED_YAG,SEVR5=NO_ALARM,STATE6=SiN,SEVR6=NO_ALARM,STATE7=OUT,SEVR7=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DSB:MMS:13,ALIAS=CXI:DSB:MMS:13:STATES:MOTOR" )



var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-cxi-dsb-ims/autosave" )

set_pass0_restoreFile( "ioc-cxi-dsb-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-cxi-dsb-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

