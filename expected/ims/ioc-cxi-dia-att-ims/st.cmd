#!/cds/group/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:CXI:DIA:ATT:IMS" )
epicsEnvSet( "LOCATION",             "CXI:DIA"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-cxi-dia-att-ims> " )

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










dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DIA:MMS:01,PORT=digi-cxi-32:2101,ASYN=CXI:DIA:MMS:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:PPATT:MIRROR,STATE=IN,SET=25,DELTA=0.5,MOVER=CXI:DIA:MMS:01.VAL,RBV=CXI:DIA:MMS:01.RBV,DMOV=CXI:DIA:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:PPATT:MIRROR,STATE=OUT,SET=0,DELTA=5.0,MOVER=CXI:DIA:MMS:01.VAL,RBV=CXI:DIA:MMS:01.RBV,DMOV=CXI:DIA:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=CXI:DIA:PPATT:MIRROR,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DIA:MMS:01,ALIAS=CXI:DIA:PPATT:MIRROR:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DIA:MMS:02,PORT=digi-cxi-32:2102,ASYN=CXI:DIA:MMS:02,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:ATT:20UM,STATE=IN,SET=0.5,DELTA=3,MOVER=CXI:DIA:MMS:02.VAL,RBV=CXI:DIA:MMS:02.RBV,DMOV=CXI:DIA:MMS:02.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:ATT:20UM,STATE=OUT,SET=-25.55,DELTA=6,MOVER=CXI:DIA:MMS:02.VAL,RBV=CXI:DIA:MMS:02.RBV,DMOV=CXI:DIA:MMS:02.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=CXI:DIA:ATT:20UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DIA:MMS:02,ALIAS=CXI:DIA:ATT:20UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DIA:MMS:03,PORT=digi-cxi-32:2103,ASYN=CXI:DIA:MMS:03,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:ATT:40UM,STATE=IN,SET=0.5,DELTA=3,MOVER=CXI:DIA:MMS:03.VAL,RBV=CXI:DIA:MMS:03.RBV,DMOV=CXI:DIA:MMS:03.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:ATT:40UM,STATE=OUT,SET=-25.65,DELTA=6,MOVER=CXI:DIA:MMS:03.VAL,RBV=CXI:DIA:MMS:03.RBV,DMOV=CXI:DIA:MMS:03.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=CXI:DIA:ATT:40UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DIA:MMS:03,ALIAS=CXI:DIA:ATT:40UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DIA:MMS:04,PORT=digi-cxi-32:2104,ASYN=CXI:DIA:MMS:04,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:ATT:80UM,STATE=IN,SET=0.5,DELTA=3,MOVER=CXI:DIA:MMS:04.VAL,RBV=CXI:DIA:MMS:04.RBV,DMOV=CXI:DIA:MMS:04.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:ATT:80UM,STATE=OUT,SET=-17,DELTA=6,MOVER=CXI:DIA:MMS:04.VAL,RBV=CXI:DIA:MMS:04.RBV,DMOV=CXI:DIA:MMS:04.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=CXI:DIA:ATT:80UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DIA:MMS:04,ALIAS=CXI:DIA:ATT:80UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DIA:MMS:05,PORT=digi-cxi-32:2105,ASYN=CXI:DIA:MMS:05,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:ATT:10240UM,STATE=IN,SET=0.5,DELTA=3,MOVER=CXI:DIA:MMS:05.VAL,RBV=CXI:DIA:MMS:05.RBV,DMOV=CXI:DIA:MMS:05.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:ATT:10240UM,STATE=OUT,SET=-14.7,DELTA=6,MOVER=CXI:DIA:MMS:05.VAL,RBV=CXI:DIA:MMS:05.RBV,DMOV=CXI:DIA:MMS:05.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=CXI:DIA:ATT:10240UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DIA:MMS:05,ALIAS=CXI:DIA:ATT:10240UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DIA:MMS:06,PORT=digi-cxi-32:2106,ASYN=CXI:DIA:MMS:06,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:ATT:320UM,STATE=IN,SET=0.5,DELTA=3,MOVER=CXI:DIA:MMS:06.VAL,RBV=CXI:DIA:MMS:06.RBV,DMOV=CXI:DIA:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:ATT:320UM,STATE=OUT,SET=-15.8,DELTA=6,MOVER=CXI:DIA:MMS:06.VAL,RBV=CXI:DIA:MMS:06.RBV,DMOV=CXI:DIA:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=CXI:DIA:ATT:320UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DIA:MMS:06,ALIAS=CXI:DIA:ATT:320UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DIA:MMS:07,PORT=digi-cxi-32:2107,ASYN=CXI:DIA:MMS:07,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:ATT:640UM,STATE=IN,SET=0.5,DELTA=3,MOVER=CXI:DIA:MMS:07.VAL,RBV=CXI:DIA:MMS:07.RBV,DMOV=CXI:DIA:MMS:07.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:ATT:640UM,STATE=OUT,SET=-27.55,DELTA=6,MOVER=CXI:DIA:MMS:07.VAL,RBV=CXI:DIA:MMS:07.RBV,DMOV=CXI:DIA:MMS:07.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=CXI:DIA:ATT:640UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DIA:MMS:07,ALIAS=CXI:DIA:ATT:640UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DIA:MMS:08,PORT=digi-cxi-32:2108,ASYN=CXI:DIA:MMS:08,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:ATT:1280UM,STATE=IN,SET=0.5,DELTA=3,MOVER=CXI:DIA:MMS:08.VAL,RBV=CXI:DIA:MMS:08.RBV,DMOV=CXI:DIA:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:ATT:1280UM,STATE=OUT,SET=-17.9,DELTA=6,MOVER=CXI:DIA:MMS:08.VAL,RBV=CXI:DIA:MMS:08.RBV,DMOV=CXI:DIA:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=CXI:DIA:ATT:1280UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DIA:MMS:08,ALIAS=CXI:DIA:ATT:1280UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DIA:MMS:09,PORT=digi-cxi-32:2109,ASYN=CXI:DIA:MMS:09,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:ATT:2560UM,STATE=IN,SET=0.5,DELTA=3,MOVER=CXI:DIA:MMS:09.VAL,RBV=CXI:DIA:MMS:09.RBV,DMOV=CXI:DIA:MMS:09.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:ATT:2560UM,STATE=OUT,SET=-16.5,DELTA=6,MOVER=CXI:DIA:MMS:09.VAL,RBV=CXI:DIA:MMS:09.RBV,DMOV=CXI:DIA:MMS:09.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=CXI:DIA:ATT:2560UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DIA:MMS:09,ALIAS=CXI:DIA:ATT:2560UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DIA:MMS:10,PORT=digi-cxi-32:2110,ASYN=CXI:DIA:MMS:10,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:ATT:5120UM,STATE=IN,SET=0.5,DELTA=0.2,MOVER=CXI:DIA:MMS:10.VAL,RBV=CXI:DIA:MMS:10.RBV,DMOV=CXI:DIA:MMS:10.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:ATT:5120UM,STATE=OUT,SET=-18.4,DELTA=0.2,MOVER=CXI:DIA:MMS:10.VAL,RBV=CXI:DIA:MMS:10.RBV,DMOV=CXI:DIA:MMS:10.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=CXI:DIA:ATT:5120UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DIA:MMS:10,ALIAS=CXI:DIA:ATT:5120UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DIA:MMS:11,PORT=digi-cxi-32:2111,ASYN=CXI:DIA:MMS:11,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:ATT:160UM,STATE=IN,SET=0.5,DELTA=3,MOVER=CXI:DIA:MMS:11.VAL,RBV=CXI:DIA:MMS:11.RBV,DMOV=CXI:DIA:MMS:11.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:ATT:160UM,STATE=OUT,SET=-17.77,DELTA=6,MOVER=CXI:DIA:MMS:11.VAL,RBV=CXI:DIA:MMS:11.RBV,DMOV=CXI:DIA:MMS:11.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=CXI:DIA:ATT:160UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DIA:MMS:11,ALIAS=CXI:DIA:ATT:160UM:MOTOR" )






var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-cxi-dia-att-ims/autosave" )

set_pass0_restoreFile( "ioc-cxi-dia-att-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-cxi-dia-att-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

