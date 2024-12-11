#!/reg/g/pcds/epics/ioc/common/ims/R6.3.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XRT:MECPPATT:IMS" )
epicsEnvSet( "LOCATION",             "XRT:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xrt-mecppatt-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Peregrine McGehee (peregrin)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME),P=$(EPICS_NAME):" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )










dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:HXM:MMS:04,PORT=moxa-xrt-mec06:4004,ASYN=MEC:HXM:MMS:04,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:ATT:MIRROR,STATE=IN,SET=25,DELTA=0.5,MOVER=MEC:HXM:MMS:04.VAL,RBV=MEC:HXM:MMS:04.RBV,DMOV=MEC:HXM:MMS:04.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:ATT:MIRROR,STATE=OUT,SET=0,DELTA=5.0,MOVER=MEC:HXM:MMS:04.VAL,RBV=MEC:HXM:MMS:04.RBV,DMOV=MEC:HXM:MMS:04.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MEC:ATT:MIRROR,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:HXM:MMS:04,ALIAS=MEC:ATT:MIRROR:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:HXM:MMS:05,PORT=moxa-xrt-mec06:4005,ASYN=MEC:HXM:MMS:05,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:ATT:20UM,STATE=IN,SET=21,DELTA=0.5,MOVER=MEC:HXM:MMS:05.VAL,RBV=MEC:HXM:MMS:05.RBV,DMOV=MEC:HXM:MMS:05.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:ATT:20UM,STATE=OUT,SET=1,DELTA=5.0,MOVER=MEC:HXM:MMS:05.VAL,RBV=MEC:HXM:MMS:05.RBV,DMOV=MEC:HXM:MMS:05.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MEC:ATT:20UM,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:HXM:MMS:05,ALIAS=MEC:ATT:20UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:HXM:MMS:06,PORT=moxa-xrt-mec06:4006,ASYN=MEC:HXM:MMS:06,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:ATT:40UM,STATE=IN,SET=25,DELTA=0.5,MOVER=MEC:HXM:MMS:06.VAL,RBV=MEC:HXM:MMS:06.RBV,DMOV=MEC:HXM:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:ATT:40UM,STATE=OUT,SET=1,DELTA=5.0,MOVER=MEC:HXM:MMS:06.VAL,RBV=MEC:HXM:MMS:06.RBV,DMOV=MEC:HXM:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MEC:ATT:40UM,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:HXM:MMS:06,ALIAS=MEC:ATT:40UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:HXM:MMS:07,PORT=moxa-xrt-mec06:4007,ASYN=MEC:HXM:MMS:07,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:ATT:80UM,STATE=IN,SET=25,DELTA=0.5,MOVER=MEC:HXM:MMS:07.VAL,RBV=MEC:HXM:MMS:07.RBV,DMOV=MEC:HXM:MMS:07.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:ATT:80UM,STATE=OUT,SET=1,DELTA=5.0,MOVER=MEC:HXM:MMS:07.VAL,RBV=MEC:HXM:MMS:07.RBV,DMOV=MEC:HXM:MMS:07.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MEC:ATT:80UM,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:HXM:MMS:07,ALIAS=MEC:ATT:80UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:HXM:MMS:08,PORT=moxa-xrt-mec06:4008,ASYN=MEC:HXM:MMS:08,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:ATT:160UM,STATE=IN,SET=25,DELTA=0.5,MOVER=MEC:HXM:MMS:08.VAL,RBV=MEC:HXM:MMS:08.RBV,DMOV=MEC:HXM:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:ATT:160UM,STATE=OUT,SET=1,DELTA=5.0,MOVER=MEC:HXM:MMS:08.VAL,RBV=MEC:HXM:MMS:08.RBV,DMOV=MEC:HXM:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MEC:ATT:160UM,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:HXM:MMS:08,ALIAS=MEC:ATT:160UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:HXM:MMS:09,PORT=moxa-xrt-mec06:4009,ASYN=MEC:HXM:MMS:09,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:ATT:320UM,STATE=IN,SET=25,DELTA=0.5,MOVER=MEC:HXM:MMS:09.VAL,RBV=MEC:HXM:MMS:09.RBV,DMOV=MEC:HXM:MMS:09.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:ATT:320UM,STATE=OUT,SET=1,DELTA=5.0,MOVER=MEC:HXM:MMS:09.VAL,RBV=MEC:HXM:MMS:09.RBV,DMOV=MEC:HXM:MMS:09.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MEC:ATT:320UM,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:HXM:MMS:09,ALIAS=MEC:ATT:320UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:HXM:MMS:10,PORT=moxa-xrt-mec06:4010,ASYN=MEC:HXM:MMS:10,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:ATT:640UM,STATE=IN,SET=25,DELTA=0.5,MOVER=MEC:HXM:MMS:10.VAL,RBV=MEC:HXM:MMS:10.RBV,DMOV=MEC:HXM:MMS:10.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:ATT:640UM,STATE=OUT,SET=1,DELTA=5.0,MOVER=MEC:HXM:MMS:10.VAL,RBV=MEC:HXM:MMS:10.RBV,DMOV=MEC:HXM:MMS:10.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MEC:ATT:640UM,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:HXM:MMS:10,ALIAS=MEC:ATT:640UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:HXM:MMS:11,PORT=moxa-xrt-mec06:4011,ASYN=MEC:HXM:MMS:11,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:ATT:1280UM,STATE=IN,SET=25,DELTA=0.5,MOVER=MEC:HXM:MMS:11.VAL,RBV=MEC:HXM:MMS:11.RBV,DMOV=MEC:HXM:MMS:11.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:ATT:1280UM,STATE=OUT,SET=1,DELTA=5.0,MOVER=MEC:HXM:MMS:11.VAL,RBV=MEC:HXM:MMS:11.RBV,DMOV=MEC:HXM:MMS:11.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MEC:ATT:1280UM,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:HXM:MMS:11,ALIAS=MEC:ATT:1280UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:HXM:MMS:12,PORT=moxa-xrt-mec06:4012,ASYN=MEC:HXM:MMS:12,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:ATT:2560UM,STATE=IN,SET=25,DELTA=0.5,MOVER=MEC:HXM:MMS:12.VAL,RBV=MEC:HXM:MMS:12.RBV,DMOV=MEC:HXM:MMS:12.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:ATT:2560UM,STATE=OUT,SET=1,DELTA=5.0,MOVER=MEC:HXM:MMS:12.VAL,RBV=MEC:HXM:MMS:12.RBV,DMOV=MEC:HXM:MMS:12.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MEC:ATT:2560UM,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:HXM:MMS:12,ALIAS=MEC:ATT:2560UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:HXM:MMS:13,PORT=moxa-xrt-mec06:4013,ASYN=MEC:HXM:MMS:13,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:ATT:5120UM,STATE=IN,SET=25,DELTA=0.5,MOVER=MEC:HXM:MMS:13.VAL,RBV=MEC:HXM:MMS:13.RBV,DMOV=MEC:HXM:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:ATT:5120UM,STATE=OUT,SET=1,DELTA=5.0,MOVER=MEC:HXM:MMS:13.VAL,RBV=MEC:HXM:MMS:13.RBV,DMOV=MEC:HXM:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MEC:ATT:5120UM,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:HXM:MMS:13,ALIAS=MEC:ATT:5120UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:HXM:MMS:14,PORT=moxa-xrt-mec06:4014,ASYN=MEC:HXM:MMS:14,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:ATT:10240UM,STATE=IN,SET=25,DELTA=0.5,MOVER=MEC:HXM:MMS:14.VAL,RBV=MEC:HXM:MMS:14.RBV,DMOV=MEC:HXM:MMS:14.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:ATT:10240UM,STATE=OUT,SET=1,DELTA=5.0,MOVER=MEC:HXM:MMS:14.VAL,RBV=MEC:HXM:MMS:14.RBV,DMOV=MEC:HXM:MMS:14.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MEC:ATT:10240UM,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:HXM:MMS:14,ALIAS=MEC:ATT:10240UM:MOTOR" )






var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xrt-mecppatt-ims/autosave" )

set_pass0_restoreFile( "ioc-xrt-mecppatt-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xrt-mecppatt-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

