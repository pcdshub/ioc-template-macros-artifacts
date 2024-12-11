#!/reg/g/pcds/epics/ioc/common/ims/R6.3.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XRT:DIA:PPATT:IMS" )
epicsEnvSet( "LOCATION",             "XRT:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xrt-dia-ppatt-ims> " )

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
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME),P=$(EPICS_NAME):" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )










dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XRT:DIA:MMS:01,PORT=digi-hxx-cxi01:2101,ASYN=XRT:DIA:MMS:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:PPATT:MIRROR,STATE=IN,SET=25,DELTA=0.5,MOVER=XRT:DIA:MMS:01.VAL,RBV=XRT:DIA:MMS:01.RBV,DMOV=XRT:DIA:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:PPATT:MIRROR,STATE=OUT,SET=0,DELTA=5.0,MOVER=XRT:DIA:MMS:01.VAL,RBV=XRT:DIA:MMS:01.RBV,DMOV=XRT:DIA:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XRT:DIA:PPATT:MIRROR,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XRT:DIA:MMS:01,ALIAS=XRT:DIA:PPATT:MIRROR:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XRT:DIA:MMS:02,PORT=digi-hxx-cxi01:2102,ASYN=XRT:DIA:MMS:02,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:ATT:20UM,STATE=IN,SET=-0.0156,DELTA=0.05,MOVER=XRT:DIA:MMS:02.VAL,RBV=XRT:DIA:MMS:02.RBV,DMOV=XRT:DIA:MMS:02.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:ATT:20UM,STATE=OUT,SET=-15.0503,DELTA=0.05,MOVER=XRT:DIA:MMS:02.VAL,RBV=XRT:DIA:MMS:02.RBV,DMOV=XRT:DIA:MMS:02.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XRT:DIA:ATT:20UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XRT:DIA:MMS:02,ALIAS=XRT:DIA:ATT:20UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XRT:DIA:MMS:03,PORT=digi-hxx-cxi01:2103,ASYN=XRT:DIA:MMS:03,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:ATT:40UM,STATE=IN,SET=-0.0806,DELTA=0.05,MOVER=XRT:DIA:MMS:03.VAL,RBV=XRT:DIA:MMS:03.RBV,DMOV=XRT:DIA:MMS:03.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:ATT:40UM,STATE=OUT,SET=-16.3862,DELTA=0.05,MOVER=XRT:DIA:MMS:03.VAL,RBV=XRT:DIA:MMS:03.RBV,DMOV=XRT:DIA:MMS:03.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XRT:DIA:ATT:40UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XRT:DIA:MMS:03,ALIAS=XRT:DIA:ATT:40UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XRT:DIA:MMS:04,PORT=digi-hxx-cxi01:2104,ASYN=XRT:DIA:MMS:04,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:ATT:80UM,STATE=IN,SET=-0.0205,DELTA=0.05,MOVER=XRT:DIA:MMS:04.VAL,RBV=XRT:DIA:MMS:04.RBV,DMOV=XRT:DIA:MMS:04.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:ATT:80UM,STATE=OUT,SET=-16.4780,DELTA=0.05,MOVER=XRT:DIA:MMS:04.VAL,RBV=XRT:DIA:MMS:04.RBV,DMOV=XRT:DIA:MMS:04.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XRT:DIA:ATT:80UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XRT:DIA:MMS:04,ALIAS=XRT:DIA:ATT:80UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XRT:DIA:MMS:11,PORT=digi-hxx-cxi01:2111,ASYN=XRT:DIA:MMS:11,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:ATT:160UM,STATE=IN,SET=-0.0879,DELTA=0.05,MOVER=XRT:DIA:MMS:11.VAL,RBV=XRT:DIA:MMS:11.RBV,DMOV=XRT:DIA:MMS:11.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:ATT:160UM,STATE=OUT,SET=-16.0601,DELTA=0.05,MOVER=XRT:DIA:MMS:11.VAL,RBV=XRT:DIA:MMS:11.RBV,DMOV=XRT:DIA:MMS:11.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XRT:DIA:ATT:160UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XRT:DIA:MMS:11,ALIAS=XRT:DIA:ATT:160UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XRT:DIA:MMS:06,PORT=digi-hxx-cxi01:2106,ASYN=XRT:DIA:MMS:06,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:ATT:320UM,STATE=IN,SET=0.0010,DELTA=0.05,MOVER=XRT:DIA:MMS:06.VAL,RBV=XRT:DIA:MMS:06.RBV,DMOV=XRT:DIA:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:ATT:320UM,STATE=OUT,SET=-15.2070,DELTA=0.05,MOVER=XRT:DIA:MMS:06.VAL,RBV=XRT:DIA:MMS:06.RBV,DMOV=XRT:DIA:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XRT:DIA:ATT:320UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XRT:DIA:MMS:06,ALIAS=XRT:DIA:ATT:320UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XRT:DIA:MMS:07,PORT=digi-hxx-cxi01:2107,ASYN=XRT:DIA:MMS:07,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:ATT:640UM,STATE=IN,SET=-0.0146,DELTA=0.05,MOVER=XRT:DIA:MMS:07.VAL,RBV=XRT:DIA:MMS:07.RBV,DMOV=XRT:DIA:MMS:07.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:ATT:640UM,STATE=OUT,SET=-16.4678,DELTA=0.05,MOVER=XRT:DIA:MMS:07.VAL,RBV=XRT:DIA:MMS:07.RBV,DMOV=XRT:DIA:MMS:07.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XRT:DIA:ATT:640UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XRT:DIA:MMS:07,ALIAS=XRT:DIA:ATT:640UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XRT:DIA:MMS:08,PORT=digi-hxx-cxi01:2108,ASYN=XRT:DIA:MMS:08,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:ATT:1280UM,STATE=IN,SET=-0.0068,DELTA=0.05,MOVER=XRT:DIA:MMS:08.VAL,RBV=XRT:DIA:MMS:08.RBV,DMOV=XRT:DIA:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:ATT:1280UM,STATE=OUT,SET=-17.3623,DELTA=0.05,MOVER=XRT:DIA:MMS:08.VAL,RBV=XRT:DIA:MMS:08.RBV,DMOV=XRT:DIA:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XRT:DIA:ATT:1280UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XRT:DIA:MMS:08,ALIAS=XRT:DIA:ATT:1280UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XRT:DIA:MMS:09,PORT=digi-hxx-cxi01:2109,ASYN=XRT:DIA:MMS:09,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:ATT:2560UM,STATE=IN,SET=0.0352,DELTA=0.05,MOVER=XRT:DIA:MMS:09.VAL,RBV=XRT:DIA:MMS:09.RBV,DMOV=XRT:DIA:MMS:09.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:ATT:2560UM,STATE=OUT,SET=-15.9424,DELTA=0.05,MOVER=XRT:DIA:MMS:09.VAL,RBV=XRT:DIA:MMS:09.RBV,DMOV=XRT:DIA:MMS:09.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XRT:DIA:ATT:2560UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XRT:DIA:MMS:09,ALIAS=XRT:DIA:ATT:2560UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XRT:DIA:MMS:10,PORT=digi-hxx-cxi01:2110,ASYN=XRT:DIA:MMS:10,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:ATT:5120UM,STATE=IN,SET=0.0498,DELTA=0.05,MOVER=XRT:DIA:MMS:10.VAL,RBV=XRT:DIA:MMS:10.RBV,DMOV=XRT:DIA:MMS:10.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:ATT:5120UM,STATE=OUT,SET=-17.8159,DELTA=0.05,MOVER=XRT:DIA:MMS:10.VAL,RBV=XRT:DIA:MMS:10.RBV,DMOV=XRT:DIA:MMS:10.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XRT:DIA:ATT:5120UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XRT:DIA:MMS:10,ALIAS=XRT:DIA:ATT:5120UM:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XRT:DIA:MMS:05,PORT=digi-hxx-cxi01:2105,ASYN=XRT:DIA:MMS:05,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:ATT:10240UM,STATE=IN,SET=-2.2817,DELTA=0.05,MOVER=XRT:DIA:MMS:05.VAL,RBV=XRT:DIA:MMS:05.RBV,DMOV=XRT:DIA:MMS:05.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:DIA:ATT:10240UM,STATE=OUT,SET=-16.8774,DELTA=0.05,MOVER=XRT:DIA:MMS:05.VAL,RBV=XRT:DIA:MMS:05.RBV,DMOV=XRT:DIA:MMS:05.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XRT:DIA:ATT:10240UM,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XRT:DIA:MMS:05,ALIAS=XRT:DIA:ATT:10240UM:MOTOR" )






var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xrt-dia-ppatt-ims/autosave" )

set_pass0_restoreFile( "ioc-xrt-dia-ppatt-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xrt-dia-ppatt-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

