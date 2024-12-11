#!/reg/g/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XPP:SB2:PPATT:IMS" )
epicsEnvSet( "LOCATION",             "XPP:SB2"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xpp-sb2-ppatt-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Silke Nelson (snelson)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME),P=$(EPICS_NAME):" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )










dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:27,PORT=moxa-xpp-08:4011,ASYN=XPP:SB2:MMS:27,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:ATT:MIRROR,STATE=IN,SET=25,DELTA=0.5,MOVER=XPP:SB2:MMS:27.VAL,RBV=XPP:SB2:MMS:27.RBV,DMOV=XPP:SB2:MMS:27.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:ATT:MIRROR,STATE=OUT,SET=0,DELTA=5.0,MOVER=XPP:SB2:MMS:27.VAL,RBV=XPP:SB2:MMS:27.RBV,DMOV=XPP:SB2:MMS:27.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XPP:ATT:MIRROR,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:SB2:MMS:27,ALIAS=XPP:ATT:MIRROR:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:26,PORT=moxa-xpp-08:4010,ASYN=XPP:SB2:MMS:26,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:ATT:20UM,STATE=IN,SET=20,DELTA=0.05,MOVER=XPP:SB2:MMS:26.VAL,RBV=XPP:SB2:MMS:26.RBV,DMOV=XPP:SB2:MMS:26.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:ATT:20UM,STATE=OUT,SET=0.5,DELTA=0.05,MOVER=XPP:SB2:MMS:26.VAL,RBV=XPP:SB2:MMS:26.RBV,DMOV=XPP:SB2:MMS:26.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XPP:ATT:20UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:SB2:MMS:26,ALIAS=XPP:ATT:20UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:25,PORT=moxa-xpp-08:4009,ASYN=XPP:SB2:MMS:25,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:ATT:40UM,STATE=IN,SET=22,DELTA=0.05,MOVER=XPP:SB2:MMS:25.VAL,RBV=XPP:SB2:MMS:25.RBV,DMOV=XPP:SB2:MMS:25.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:ATT:40UM,STATE=OUT,SET=0.5,DELTA=0.05,MOVER=XPP:SB2:MMS:25.VAL,RBV=XPP:SB2:MMS:25.RBV,DMOV=XPP:SB2:MMS:25.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XPP:ATT:40UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:SB2:MMS:25,ALIAS=XPP:ATT:40UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:24,PORT=moxa-xpp-08:4008,ASYN=XPP:SB2:MMS:24,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:ATT:80UM,STATE=IN,SET=20,DELTA=0.05,MOVER=XPP:SB2:MMS:24.VAL,RBV=XPP:SB2:MMS:24.RBV,DMOV=XPP:SB2:MMS:24.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:ATT:80UM,STATE=OUT,SET=0.5,DELTA=0.05,MOVER=XPP:SB2:MMS:24.VAL,RBV=XPP:SB2:MMS:24.RBV,DMOV=XPP:SB2:MMS:24.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XPP:ATT:80UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:SB2:MMS:24,ALIAS=XPP:ATT:80UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:23,PORT=moxa-xpp-08:4007,ASYN=XPP:SB2:MMS:23,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:ATT:160UM,STATE=IN,SET=19,DELTA=0.05,MOVER=XPP:SB2:MMS:23.VAL,RBV=XPP:SB2:MMS:23.RBV,DMOV=XPP:SB2:MMS:23.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:ATT:160UM,STATE=OUT,SET=0.5,DELTA=0.05,MOVER=XPP:SB2:MMS:23.VAL,RBV=XPP:SB2:MMS:23.RBV,DMOV=XPP:SB2:MMS:23.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XPP:ATT:160UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:SB2:MMS:23,ALIAS=XPP:ATT:160UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:22,PORT=moxa-xpp-08:4006,ASYN=XPP:SB2:MMS:22,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:ATT:320UM,STATE=IN,SET=20,DELTA=0.05,MOVER=XPP:SB2:MMS:22.VAL,RBV=XPP:SB2:MMS:22.RBV,DMOV=XPP:SB2:MMS:22.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:ATT:320UM,STATE=OUT,SET=0.5,DELTA=0.05,MOVER=XPP:SB2:MMS:22.VAL,RBV=XPP:SB2:MMS:22.RBV,DMOV=XPP:SB2:MMS:22.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XPP:ATT:320UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:SB2:MMS:22,ALIAS=XPP:ATT:320UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:21,PORT=moxa-xpp-08:4005,ASYN=XPP:SB2:MMS:21,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:ATT:640UM,STATE=IN,SET=20,DELTA=0.05,MOVER=XPP:SB2:MMS:21.VAL,RBV=XPP:SB2:MMS:21.RBV,DMOV=XPP:SB2:MMS:21.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:ATT:640UM,STATE=OUT,SET=0.5,DELTA=0.05,MOVER=XPP:SB2:MMS:21.VAL,RBV=XPP:SB2:MMS:21.RBV,DMOV=XPP:SB2:MMS:21.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XPP:ATT:640UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:SB2:MMS:21,ALIAS=XPP:ATT:640UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:20,PORT=moxa-xpp-08:4004,ASYN=XPP:SB2:MMS:20,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:ATT:1280UM,STATE=IN,SET=20,DELTA=0.05,MOVER=XPP:SB2:MMS:20.VAL,RBV=XPP:SB2:MMS:20.RBV,DMOV=XPP:SB2:MMS:20.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:ATT:1280UM,STATE=OUT,SET=0.5,DELTA=0.05,MOVER=XPP:SB2:MMS:20.VAL,RBV=XPP:SB2:MMS:20.RBV,DMOV=XPP:SB2:MMS:20.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XPP:ATT:1280UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:SB2:MMS:20,ALIAS=XPP:ATT:1280UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:19,PORT=moxa-xpp-08:4003,ASYN=XPP:SB2:MMS:19,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:ATT:2560UM,STATE=IN,SET=20,DELTA=0.05,MOVER=XPP:SB2:MMS:19.VAL,RBV=XPP:SB2:MMS:19.RBV,DMOV=XPP:SB2:MMS:19.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:ATT:2560UM,STATE=OUT,SET=0.5,DELTA=0.05,MOVER=XPP:SB2:MMS:19.VAL,RBV=XPP:SB2:MMS:19.RBV,DMOV=XPP:SB2:MMS:19.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XPP:ATT:2560UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:SB2:MMS:19,ALIAS=XPP:ATT:2560UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:18,PORT=moxa-xpp-08:4002,ASYN=XPP:SB2:MMS:18,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:ATT:5120UM,STATE=IN,SET=20,DELTA=0.05,MOVER=XPP:SB2:MMS:18.VAL,RBV=XPP:SB2:MMS:18.RBV,DMOV=XPP:SB2:MMS:18.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:ATT:5120UM,STATE=OUT,SET=0.5,DELTA=0.05,MOVER=XPP:SB2:MMS:18.VAL,RBV=XPP:SB2:MMS:18.RBV,DMOV=XPP:SB2:MMS:18.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XPP:ATT:5120UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:SB2:MMS:18,ALIAS=XPP:ATT:5120UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:17,PORT=moxa-xpp-08:4001,ASYN=XPP:SB2:MMS:17,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:ATT:10240UM,STATE=IN,SET=20,DELTA=0.05,MOVER=XPP:SB2:MMS:17.VAL,RBV=XPP:SB2:MMS:17.RBV,DMOV=XPP:SB2:MMS:17.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:ATT:10240UM,STATE=OUT,SET=0.5,DELTA=0.05,MOVER=XPP:SB2:MMS:17.VAL,RBV=XPP:SB2:MMS:17.RBV,DMOV=XPP:SB2:MMS:17.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XPP:ATT:10240UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:SB2:MMS:17,ALIAS=XPP:ATT:10240UM:MOTOR" )






var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xpp-sb2-ppatt-ims/autosave" )

set_pass0_restoreFile( "ioc-xpp-sb2-ppatt-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xpp-sb2-ppatt-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

