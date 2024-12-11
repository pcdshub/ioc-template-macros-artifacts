#!/reg/g/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:CXI:KB2:FMR:IMS" )
epicsEnvSet( "LOCATION",             "CXI:KB2"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-cxi-kb2-fmr-ims> " )

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











dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=CXI:KB2:MMS:01,PORT=moxa-cxi-10:4001,ASYN=CXI:KB2:MMS:01,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=CXI:KB2:MMS:02,PORT=moxa-cxi-10:4002,ASYN=CXI:KB2:MMS:02,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=CXI:KB2:MMS:03,PORT=moxa-cxi-10:4003,ASYN=CXI:KB2:MMS:03,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=CXI:KB2:MMS:04,PORT=moxa-cxi-10:4004,ASYN=CXI:KB2:MMS:04,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=CXI:KB2:MMS:05,PORT=moxa-cxi-10:4005,ASYN=CXI:KB2:MMS:05,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=CXI:KB2:MMS:06,PORT=moxa-cxi-10:4006,ASYN=CXI:KB2:MMS:06,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=CXI:KB2:MMS:07,PORT=moxa-cxi-10:4007,ASYN=CXI:KB2:MMS:07,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=CXI:KB2:MMS:08,PORT=moxa-cxi-10:4008,ASYN=CXI:KB2:MMS:08,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )


dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:KB2:MMS:01:STATES,STATE=OUT,SET=-30,DELTA=0.5,MOVER=CXI:KB2:MMS:01.VAL,RBV=CXI:KB2:MMS:01.RBV,DMOV=CXI:KB2:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:KB2:MMS:01:STATES,STATE=IN,SET=-15.1937,DELTA=0.5,MOVER=CXI:KB2:MMS:01.VAL,RBV=CXI:KB2:MMS:01.RBV,DMOV=CXI:KB2:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=CXI:KB2:MMS:01:STATES,STATE1=OUT,SEVR1=NO_ALARM,STATE2=IN,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:KB2:MMS:01,ALIAS=CXI:KB2:MMS:01:STATES:MOTOR" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:KB2:MMS:07:STATES,STATE=OUT,SET=0,DELTA=0.5,MOVER=CXI:KB2:MMS:07.VAL,RBV=CXI:KB2:MMS:07.RBV,DMOV=CXI:KB2:MMS:07.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:KB2:MMS:07:STATES,STATE=IN,SET=13.1,DELTA=0.5,MOVER=CXI:KB2:MMS:07.VAL,RBV=CXI:KB2:MMS:07.RBV,DMOV=CXI:KB2:MMS:07.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=CXI:KB2:MMS:07:STATES,STATE1=OUT,SEVR1=NO_ALARM,STATE2=IN,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:KB2:MMS:07,ALIAS=CXI:KB2:MMS:07:STATES:MOTOR" )



var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-cxi-kb2-fmr-ims/autosave" )

set_pass0_restoreFile( "ioc-cxi-kb2-fmr-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-cxi-kb2-fmr-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

