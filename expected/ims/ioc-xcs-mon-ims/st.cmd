#!/reg/g/pcds/epics/ioc/common/ims/R6.0.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XCS:MON:IMS" )
epicsEnvSet( "LOCATION",             "XRT:MON"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xcs-mon-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Tyler Pennebaker (pennebak)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:MON:MMS:29,PORT=moxa-xcs-07:4009,ASYN=XCS:MON:MMS:29,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:MON:MMS:30,PORT=moxa-xcs-07:4010,ASYN=XCS:MON:MMS:30,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:MON:MMS:31,PORT=moxa-xcs-07:4011,ASYN=XCS:MON:MMS:31,DVER=$(DVER),ERBL=" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:MON:IPM:DIODE,STATE=IN,SET=0,DELTA=0.9,MOVER=XCS:MON:MMS:30.VAL,RBV=XCS:MON:MMS:30.RBV,DMOV=XCS:MON:MMS:30.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:MON:IPM:DIODE,STATE=OUT,SET=-40,DELTA=0.5,MOVER=XCS:MON:MMS:30.VAL,RBV=XCS:MON:MMS:30.RBV,DMOV=XCS:MON:MMS:30.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:MON:IPM:DIODE,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:MON:MMS:30,ALIAS=XCS:MON:IPM:DIODE:MOTOR" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:MON:MMS:29,ALIAS=XCS:MON:IPM:DIODE:X_MOTOR" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:MON:IPM:TARGET,STATE=TARGET1,SET=26,DELTA=0.5,MOVER=XCS:MON:MMS:31.VAL,RBV=XCS:MON:MMS:31.RBV,DMOV=XCS:MON:MMS:31.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:MON:IPM:TARGET,STATE=TARGET2,SET=39,DELTA=0.5,MOVER=XCS:MON:MMS:31.VAL,RBV=XCS:MON:MMS:31.RBV,DMOV=XCS:MON:MMS:31.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:MON:IPM:TARGET,STATE=TARGET3,SET=53,DELTA=0.5,MOVER=XCS:MON:MMS:31.VAL,RBV=XCS:MON:MMS:31.RBV,DMOV=XCS:MON:MMS:31.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:MON:IPM:TARGET,STATE=TARGET4,SET=66.3,DELTA=0.5,MOVER=XCS:MON:MMS:31.VAL,RBV=XCS:MON:MMS:31.RBV,DMOV=XCS:MON:MMS:31.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:MON:IPM:TARGET,STATE=OUT,SET=2,DELTA=1.0,MOVER=XCS:MON:MMS:31.VAL,RBV=XCS:MON:MMS:31.RBV,DMOV=XCS:MON:MMS:31.DMOV" )

dbLoadRecords( "$(TOP)/db/device_with_5states.db", "DEVICE=XCS:MON:IPM:TARGET,STATE1=TARGET1,SEVR1=MINOR,STATE2=TARGET2,SEVR2=MINOR,STATE3=TARGET3,SEVR3=MINOR,STATE4=TARGET4,SEVR4=MINOR,STATE5=OUT,SEVR5=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:MON:MMS:31,ALIAS=XCS:MON:IPM:TARGET:MOTOR" )








dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:MON:MMS:24,PORT=moxa-xcs-08:4006,ASYN=XCS:MON:MMS:24,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:CCM:X1,STATE=IN,SET=3.3,DELTA=0.5,MOVER=XCS:MON:MMS:24.VAL,RBV=XCS:MON:MMS:24.RBV,DMOV=XCS:MON:MMS:24.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:CCM:X1,STATE=OUT,SET=13.18,DELTA=0.5,MOVER=XCS:MON:MMS:24.VAL,RBV=XCS:MON:MMS:24.RBV,DMOV=XCS:MON:MMS:24.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:CCM:X1,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:MON:MMS:24,ALIAS=XCS:CCM:X1:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:MON:MMS:25,PORT=moxa-xcs-08:4007,ASYN=XCS:MON:MMS:25,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:CCM:X2,STATE=IN,SET=3.3,DELTA=0.5,MOVER=XCS:MON:MMS:25.VAL,RBV=XCS:MON:MMS:25.RBV,DMOV=XCS:MON:MMS:25.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:CCM:X2,STATE=OUT,SET=13.18,DELTA=0.5,MOVER=XCS:MON:MMS:25.VAL,RBV=XCS:MON:MMS:25.RBV,DMOV=XCS:MON:MMS:25.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:CCM:X2,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:MON:MMS:25,ALIAS=XCS:CCM:X2:MOTOR" )

dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XCS:CCM,STATE=IN,COMP1=XCS:CCM:X1,COMP2=XCS:CCM:X2" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XCS:CCM,STATE=OUT,COMP1=XCS:CCM:X1,COMP2=XCS:CCM:X2" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:CCM,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:MON:MMS:26,PORT=moxa-xcs-08:4008,ASYN=XCS:MON:MMS:26,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:MON:MMS:27,PORT=moxa-xcs-08:4009,ASYN=XCS:MON:MMS:27,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:MON:MMS:28,PORT=moxa-xcs-08:4010,ASYN=XCS:MON:MMS:28,DVER=$(DVER),ERBL=" )







var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xcs-mon-ims/autosave" )

set_pass0_restoreFile( "ioc-xcs-mon-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xcs-mon-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

