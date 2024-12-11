#!/reg/g/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:CXI:DS1:IMS" )
epicsEnvSet( "LOCATION",             "CXI:DS1"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-cxi-ds1-ims> " )

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




dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DS1:MMS:08,PORT=moxa-cxi-05:4002,ASYN=CXI:DS1:MMS:08,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DS1:XFLS:Y,STATE=LENS1,SET=-5,DELTA=0.5,MOVER=CXI:DS1:MMS:08.VAL,RBV=CXI:DS1:MMS:08.RBV,DMOV=CXI:DS1:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DS1:XFLS:Y,STATE=LENS2,SET=10,DELTA=0.5,MOVER=CXI:DS1:MMS:08.VAL,RBV=CXI:DS1:MMS:08.RBV,DMOV=CXI:DS1:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DS1:XFLS:Y,STATE=LENS3,SET=33,DELTA=0.5,MOVER=CXI:DS1:MMS:08.VAL,RBV=CXI:DS1:MMS:08.RBV,DMOV=CXI:DS1:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DS1:XFLS:Y,STATE=OUT,SET=78,DELTA=5.0,MOVER=CXI:DS1:MMS:08.VAL,RBV=CXI:DS1:MMS:08.RBV,DMOV=CXI:DS1:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=CXI:DS1:XFLS:Y,STATE1=LENS1,SEVR1=MINOR,STATE2=LENS2,SEVR2=MINOR,STATE3=LENS3,SEVR3=MINOR,STATE4=OUT,SEVR4=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DS1:MMS:08,ALIAS=CXI:DS1:XFLS:Y:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DS1:MMS:07,PORT=moxa-cxi-05:4015,ASYN=CXI:DS1:MMS:07,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DS1:XFLS:X,STATE=LENS1,SET=0,DELTA=0.1,MOVER=CXI:DS1:MMS:07.VAL,RBV=CXI:DS1:MMS:07.RBV,DMOV=CXI:DS1:MMS:07.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DS1:XFLS:X,STATE=LENS2,SET=0,DELTA=0.1,MOVER=CXI:DS1:MMS:07.VAL,RBV=CXI:DS1:MMS:07.RBV,DMOV=CXI:DS1:MMS:07.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DS1:XFLS:X,STATE=LENS3,SET=0,DELTA=0.1,MOVER=CXI:DS1:MMS:07.VAL,RBV=CXI:DS1:MMS:07.RBV,DMOV=CXI:DS1:MMS:07.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DS1:XFLS:X,STATE=OUT,SET=0,DELTA=1.0,MOVER=CXI:DS1:MMS:07.VAL,RBV=CXI:DS1:MMS:07.RBV,DMOV=CXI:DS1:MMS:07.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=CXI:DS1:XFLS:X,STATE1=LENS1,SEVR1=MINOR,STATE2=LENS2,SEVR2=MINOR,STATE3=LENS3,SEVR3=MINOR,STATE4=OUT,SEVR4=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DS1:MMS:07,ALIAS=CXI:DS1:XFLS:X:MOTOR" )

dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=CXI:DS1:XFLS,STATE=LENS1,COMP1=CXI:DS1:XFLS:Y,COMP2=CXI:DS1:XFLS:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=CXI:DS1:XFLS,STATE=LENS2,COMP1=CXI:DS1:XFLS:Y,COMP2=CXI:DS1:XFLS:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=CXI:DS1:XFLS,STATE=LENS3,COMP1=CXI:DS1:XFLS:Y,COMP2=CXI:DS1:XFLS:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=CXI:DS1:XFLS,STATE=OUT,COMP1=CXI:DS1:XFLS:Y,COMP2=CXI:DS1:XFLS:X" )
dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=CXI:DS1:XFLS,STATE1=LENS1,SEVR1=MINOR,STATE2=LENS2,SEVR2=MINOR,STATE3=LENS3,SEVR3=MINOR,STATE4=OUT,SEVR4=NO_ALARM" )






dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DS1:MMS:10,PORT=moxa-cxi-05:4008,ASYN=CXI:DS1:MMS:10,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DS1:ATT:INOUT,STATE=IN,SET=0,DELTA=2.0,MOVER=CXI:DS1:MMS:10.VAL,RBV=CXI:DS1:MMS:10.RBV,DMOV=CXI:DS1:MMS:10.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DS1:ATT:INOUT,STATE=OUT,SET=-30,DELTA=2.0,MOVER=CXI:DS1:MMS:10.VAL,RBV=CXI:DS1:MMS:10.RBV,DMOV=CXI:DS1:MMS:10.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=CXI:DS1:ATT:INOUT,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DS1:MMS:10,ALIAS=CXI:DS1:ATT:INOUT:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DS1:MMS:09,PORT=moxa-cxi-05:4003,ASYN=CXI:DS1:MMS:09,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DS1:MMS:11,PORT=moxa-cxi-05:4005,ASYN=CXI:DS1:MMS:11,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )





var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-cxi-ds1-ims/autosave" )

set_pass0_restoreFile( "ioc-cxi-ds1-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-cxi-ds1-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

