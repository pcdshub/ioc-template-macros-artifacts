#!/reg/g/pcds/epics/ioc/common/ims/R6.0.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XCS:SB2:PPATT01:IMS" )
epicsEnvSet( "LOCATION",             "XCS:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xcs-sb2-ppatt01-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Evan Rodriguez (erod)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )










dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB2:MMS:10,PORT=digi-xcs-13:2101,ASYN=XCS:SB2:MMS:10,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:ATT:MIRROR,STATE=IN,SET=0,DELTA=0.5,MOVER=XCS:SB2:MMS:10.VAL,RBV=XCS:SB2:MMS:10.RBV,DMOV=XCS:SB2:MMS:10.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:ATT:MIRROR,STATE=OUT,SET=20,DELTA=5.0,MOVER=XCS:SB2:MMS:10.VAL,RBV=XCS:SB2:MMS:10.RBV,DMOV=XCS:SB2:MMS:10.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:ATT:MIRROR,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB2:MMS:10,ALIAS=XCS:ATT:MIRROR:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB2:MMS:14,PORT=digi-xcs-13:2105,ASYN=XCS:SB2:MMS:14,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:ATT:20UM,STATE=IN,SET=20,DELTA=0.05,MOVER=XCS:SB2:MMS:14.VAL,RBV=XCS:SB2:MMS:14.RBV,DMOV=XCS:SB2:MMS:14.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:ATT:20UM,STATE=OUT,SET=0.5,DELTA=0.05,MOVER=XCS:SB2:MMS:14.VAL,RBV=XCS:SB2:MMS:14.RBV,DMOV=XCS:SB2:MMS:14.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:ATT:20UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB2:MMS:14,ALIAS=XCS:ATT:20UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB2:MMS:12,PORT=digi-xcs-13:2103,ASYN=XCS:SB2:MMS:12,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:ATT:40UM,STATE=IN,SET=20,DELTA=0.05,MOVER=XCS:SB2:MMS:12.VAL,RBV=XCS:SB2:MMS:12.RBV,DMOV=XCS:SB2:MMS:12.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:ATT:40UM,STATE=OUT,SET=0.5,DELTA=0.05,MOVER=XCS:SB2:MMS:12.VAL,RBV=XCS:SB2:MMS:12.RBV,DMOV=XCS:SB2:MMS:12.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:ATT:40UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB2:MMS:12,ALIAS=XCS:ATT:40UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB2:MMS:13,PORT=digi-xcs-13:2104,ASYN=XCS:SB2:MMS:13,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:ATT:80UM,STATE=IN,SET=20,DELTA=0.05,MOVER=XCS:SB2:MMS:13.VAL,RBV=XCS:SB2:MMS:13.RBV,DMOV=XCS:SB2:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:ATT:80UM,STATE=OUT,SET=0.5,DELTA=0.05,MOVER=XCS:SB2:MMS:13.VAL,RBV=XCS:SB2:MMS:13.RBV,DMOV=XCS:SB2:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:ATT:80UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB2:MMS:13,ALIAS=XCS:ATT:80UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB2:MMS:11,PORT=digi-xcs-13:2102,ASYN=XCS:SB2:MMS:11,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:ATT:160UM,STATE=IN,SET=20,DELTA=0.05,MOVER=XCS:SB2:MMS:11.VAL,RBV=XCS:SB2:MMS:11.RBV,DMOV=XCS:SB2:MMS:11.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:ATT:160UM,STATE=OUT,SET=0.5,DELTA=0.05,MOVER=XCS:SB2:MMS:11.VAL,RBV=XCS:SB2:MMS:11.RBV,DMOV=XCS:SB2:MMS:11.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:ATT:160UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB2:MMS:11,ALIAS=XCS:ATT:160UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB2:MMS:15,PORT=digi-xcs-13:2106,ASYN=XCS:SB2:MMS:15,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:ATT:320UM,STATE=IN,SET=20,DELTA=0.05,MOVER=XCS:SB2:MMS:15.VAL,RBV=XCS:SB2:MMS:15.RBV,DMOV=XCS:SB2:MMS:15.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:ATT:320UM,STATE=OUT,SET=0.5,DELTA=0.05,MOVER=XCS:SB2:MMS:15.VAL,RBV=XCS:SB2:MMS:15.RBV,DMOV=XCS:SB2:MMS:15.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:ATT:320UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB2:MMS:15,ALIAS=XCS:ATT:320UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB2:MMS:16,PORT=digi-xcs-13:2107,ASYN=XCS:SB2:MMS:16,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:ATT:640UM,STATE=IN,SET=20,DELTA=0.05,MOVER=XCS:SB2:MMS:16.VAL,RBV=XCS:SB2:MMS:16.RBV,DMOV=XCS:SB2:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:ATT:640UM,STATE=OUT,SET=0.5,DELTA=0.05,MOVER=XCS:SB2:MMS:16.VAL,RBV=XCS:SB2:MMS:16.RBV,DMOV=XCS:SB2:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:ATT:640UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB2:MMS:16,ALIAS=XCS:ATT:640UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB2:MMS:17,PORT=digi-xcs-13:2108,ASYN=XCS:SB2:MMS:17,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:ATT:1280UM,STATE=IN,SET=20,DELTA=0.05,MOVER=XCS:SB2:MMS:17.VAL,RBV=XCS:SB2:MMS:17.RBV,DMOV=XCS:SB2:MMS:17.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:ATT:1280UM,STATE=OUT,SET=0.5,DELTA=0.05,MOVER=XCS:SB2:MMS:17.VAL,RBV=XCS:SB2:MMS:17.RBV,DMOV=XCS:SB2:MMS:17.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:ATT:1280UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB2:MMS:17,ALIAS=XCS:ATT:1280UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB2:MMS:18,PORT=digi-xcs-13:2109,ASYN=XCS:SB2:MMS:18,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:ATT:2560UM,STATE=IN,SET=20,DELTA=0.05,MOVER=XCS:SB2:MMS:18.VAL,RBV=XCS:SB2:MMS:18.RBV,DMOV=XCS:SB2:MMS:18.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:ATT:2560UM,STATE=OUT,SET=0.5,DELTA=0.05,MOVER=XCS:SB2:MMS:18.VAL,RBV=XCS:SB2:MMS:18.RBV,DMOV=XCS:SB2:MMS:18.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:ATT:2560UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB2:MMS:18,ALIAS=XCS:ATT:2560UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB2:MMS:19,PORT=digi-xcs-13:2110,ASYN=XCS:SB2:MMS:19,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:ATT:5120UM,STATE=IN,SET=20,DELTA=0.05,MOVER=XCS:SB2:MMS:19.VAL,RBV=XCS:SB2:MMS:19.RBV,DMOV=XCS:SB2:MMS:19.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:ATT:5120UM,STATE=OUT,SET=0.5,DELTA=0.05,MOVER=XCS:SB2:MMS:19.VAL,RBV=XCS:SB2:MMS:19.RBV,DMOV=XCS:SB2:MMS:19.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:ATT:5120UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB2:MMS:19,ALIAS=XCS:ATT:5120UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB2:MMS:20,PORT=digi-xcs-13:2111,ASYN=XCS:SB2:MMS:20,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:ATT:10240UM,STATE=IN,SET=20,DELTA=0.05,MOVER=XCS:SB2:MMS:20.VAL,RBV=XCS:SB2:MMS:20.RBV,DMOV=XCS:SB2:MMS:20.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:ATT:10240UM,STATE=OUT,SET=0.5,DELTA=0.05,MOVER=XCS:SB2:MMS:20.VAL,RBV=XCS:SB2:MMS:20.RBV,DMOV=XCS:SB2:MMS:20.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:ATT:10240UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB2:MMS:20,ALIAS=XCS:ATT:10240UM:MOTOR" )






var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xcs-sb2-ppatt01-ims/autosave" )

set_pass0_restoreFile( "ioc-xcs-sb2-ppatt01-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xcs-sb2-ppatt01-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

