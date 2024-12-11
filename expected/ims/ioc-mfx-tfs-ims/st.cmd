#!/reg/g/pcds/epics/ioc/common/ims/R2.3.9/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:MFX:TFS:IMS" )
epicsEnvSet( "LOCATION",             "MFX:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-mfx-tfs-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Alex Batyuk (batyuk)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )










dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TFS:MMS:02,PORT=smc-mfx-03:2101,ASYN=MFX:TFS:MMS:02,DVER=$(DVER),ERBL=MFX:TFS:MMS:02:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:TFS:XFLS:01,STATE=IN,SET=-14,DELTA=0.5,MOVER=MFX:TFS:MMS:02.VAL,RBV=MFX:TFS:MMS:02.RBV,DMOV=MFX:TFS:MMS:02.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:TFS:XFLS:01,STATE=OUT,SET=0,DELTA=5.0,MOVER=MFX:TFS:MMS:02.VAL,RBV=MFX:TFS:MMS:02.RBV,DMOV=MFX:TFS:MMS:02.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MFX:TFS:XFLS:01,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:TFS:MMS:02,ALIAS=MFX:TFS:XFLS:01:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TFS:MMS:04,PORT=smc-mfx-03:2102,ASYN=MFX:TFS:MMS:04,DVER=$(DVER),ERBL=MFX:TFS:MMS:04:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:TFS:XFLS:02,STATE=IN,SET=-14,DELTA=0.5,MOVER=MFX:TFS:MMS:04.VAL,RBV=MFX:TFS:MMS:04.RBV,DMOV=MFX:TFS:MMS:04.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:TFS:XFLS:02,STATE=OUT,SET=0,DELTA=5.0,MOVER=MFX:TFS:MMS:04.VAL,RBV=MFX:TFS:MMS:04.RBV,DMOV=MFX:TFS:MMS:04.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MFX:TFS:XFLS:02,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:TFS:MMS:04,ALIAS=MFX:TFS:XFLS:02:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TFS:MMS:06,PORT=smc-mfx-03:2103,ASYN=MFX:TFS:MMS:06,DVER=$(DVER),ERBL=MFX:TFS:MMS:06:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:TFS:XFLS:03,STATE=IN,SET=-14,DELTA=0.5,MOVER=MFX:TFS:MMS:06.VAL,RBV=MFX:TFS:MMS:06.RBV,DMOV=MFX:TFS:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:TFS:XFLS:03,STATE=OUT,SET=0,DELTA=5.0,MOVER=MFX:TFS:MMS:06.VAL,RBV=MFX:TFS:MMS:06.RBV,DMOV=MFX:TFS:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MFX:TFS:XFLS:03,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:TFS:MMS:06,ALIAS=MFX:TFS:XFLS:03:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TFS:MMS:08,PORT=smc-mfx-03:2104,ASYN=MFX:TFS:MMS:08,DVER=$(DVER),ERBL=MFX:TFS:MMS:08:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:TFS:XFLS:04,STATE=IN,SET=-14,DELTA=0.5,MOVER=MFX:TFS:MMS:08.VAL,RBV=MFX:TFS:MMS:08.RBV,DMOV=MFX:TFS:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:TFS:XFLS:04,STATE=OUT,SET=0,DELTA=5.0,MOVER=MFX:TFS:MMS:08.VAL,RBV=MFX:TFS:MMS:08.RBV,DMOV=MFX:TFS:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MFX:TFS:XFLS:04,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:TFS:MMS:08,ALIAS=MFX:TFS:XFLS:04:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TFS:MMS:10,PORT=smc-mfx-03:2105,ASYN=MFX:TFS:MMS:10,DVER=$(DVER),ERBL=MFX:TFS:MMS:10:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:TFS:XFLS:05,STATE=IN,SET=-14,DELTA=0.5,MOVER=MFX:TFS:MMS:10.VAL,RBV=MFX:TFS:MMS:10.RBV,DMOV=MFX:TFS:MMS:10.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:TFS:XFLS:05,STATE=OUT,SET=0,DELTA=5.0,MOVER=MFX:TFS:MMS:10.VAL,RBV=MFX:TFS:MMS:10.RBV,DMOV=MFX:TFS:MMS:10.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MFX:TFS:XFLS:05,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:TFS:MMS:10,ALIAS=MFX:TFS:XFLS:05:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TFS:MMS:12,PORT=smc-mfx-03:2106,ASYN=MFX:TFS:MMS:12,DVER=$(DVER),ERBL=MFX:TFS:MMS:12:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:TFS:XFLS:06,STATE=IN,SET=-14,DELTA=0.5,MOVER=MFX:TFS:MMS:12.VAL,RBV=MFX:TFS:MMS:12.RBV,DMOV=MFX:TFS:MMS:12.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:TFS:XFLS:06,STATE=OUT,SET=0,DELTA=5.0,MOVER=MFX:TFS:MMS:12.VAL,RBV=MFX:TFS:MMS:12.RBV,DMOV=MFX:TFS:MMS:12.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MFX:TFS:XFLS:06,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:TFS:MMS:12,ALIAS=MFX:TFS:XFLS:06:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TFS:MMS:14,PORT=smc-mfx-03:2107,ASYN=MFX:TFS:MMS:14,DVER=$(DVER),ERBL=MFX:TFS:MMS:14:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:TFS:XFLS:07,STATE=IN,SET=-14,DELTA=0.5,MOVER=MFX:TFS:MMS:14.VAL,RBV=MFX:TFS:MMS:14.RBV,DMOV=MFX:TFS:MMS:14.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:TFS:XFLS:07,STATE=OUT,SET=0,DELTA=5.0,MOVER=MFX:TFS:MMS:14.VAL,RBV=MFX:TFS:MMS:14.RBV,DMOV=MFX:TFS:MMS:14.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MFX:TFS:XFLS:07,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:TFS:MMS:14,ALIAS=MFX:TFS:XFLS:07:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TFS:MMS:16,PORT=smc-mfx-03:2108,ASYN=MFX:TFS:MMS:16,DVER=$(DVER),ERBL=MFX:TFS:MMS:16:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:TFS:XFLS:08,STATE=IN,SET=-14,DELTA=0.5,MOVER=MFX:TFS:MMS:16.VAL,RBV=MFX:TFS:MMS:16.RBV,DMOV=MFX:TFS:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:TFS:XFLS:08,STATE=OUT,SET=0,DELTA=5.0,MOVER=MFX:TFS:MMS:16.VAL,RBV=MFX:TFS:MMS:16.RBV,DMOV=MFX:TFS:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MFX:TFS:XFLS:08,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:TFS:MMS:16,ALIAS=MFX:TFS:XFLS:08:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TFS:MMS:18,PORT=smc-mfx-03:2109,ASYN=MFX:TFS:MMS:18,DVER=$(DVER),ERBL=MFX:TFS:MMS:18:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:TFS:XFLS:09,STATE=IN,SET=-14,DELTA=0.5,MOVER=MFX:TFS:MMS:18.VAL,RBV=MFX:TFS:MMS:18.RBV,DMOV=MFX:TFS:MMS:18.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:TFS:XFLS:09,STATE=OUT,SET=0,DELTA=5.0,MOVER=MFX:TFS:MMS:18.VAL,RBV=MFX:TFS:MMS:18.RBV,DMOV=MFX:TFS:MMS:18.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MFX:TFS:XFLS:09,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:TFS:MMS:18,ALIAS=MFX:TFS:XFLS:09:MOTOR" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TFS:MMS:20,PORT=smc-mfx-03:2110,ASYN=MFX:TFS:MMS:20,DVER=$(DVER),ERBL=MFX:TFS:MMS:20:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:TFS:XFLS:10,STATE=IN,SET=-14,DELTA=0.5,MOVER=MFX:TFS:MMS:20.VAL,RBV=MFX:TFS:MMS:20.RBV,DMOV=MFX:TFS:MMS:20.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:TFS:XFLS:10,STATE=OUT,SET=0,DELTA=5.0,MOVER=MFX:TFS:MMS:20.VAL,RBV=MFX:TFS:MMS:20.RBV,DMOV=MFX:TFS:MMS:20.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MFX:TFS:XFLS:10,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:TFS:MMS:20,ALIAS=MFX:TFS:XFLS:10:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TFS:MMS:01,PORT=mcc-mfx-03:2101,ASYN=MFX:TFS:MMS:01,DVER=$(DVER),ERBL=MFX:TFS:MMS:01:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TFS:MMS:03,PORT=mcc-mfx-03:2102,ASYN=MFX:TFS:MMS:03,DVER=$(DVER),ERBL=MFX:TFS:MMS:03:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TFS:MMS:05,PORT=mcc-mfx-03:2103,ASYN=MFX:TFS:MMS:05,DVER=$(DVER),ERBL=MFX:TFS:MMS:05:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TFS:MMS:07,PORT=mcc-mfx-03:2104,ASYN=MFX:TFS:MMS:07,DVER=$(DVER),ERBL=MFX:TFS:MMS:07:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TFS:MMS:09,PORT=mcc-mfx-03:2105,ASYN=MFX:TFS:MMS:09,DVER=$(DVER),ERBL=MFX:TFS:MMS:09:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TFS:MMS:11,PORT=mcc-mfx-03:2106,ASYN=MFX:TFS:MMS:11,DVER=$(DVER),ERBL=MFX:TFS:MMS:11:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TFS:MMS:13,PORT=mcc-mfx-03:2107,ASYN=MFX:TFS:MMS:13,DVER=$(DVER),ERBL=MFX:TFS:MMS:13:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TFS:MMS:15,PORT=mcc-mfx-03:2108,ASYN=MFX:TFS:MMS:15,DVER=$(DVER),ERBL=MFX:TFS:MMS:15:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TFS:MMS:17,PORT=mcc-mfx-01:2016,ASYN=MFX:TFS:MMS:17,DVER=$(DVER),ERBL=MFX:TFS:MMS:17:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TFS:MMS:19,PORT=mcc-mfx-01:2107,ASYN=MFX:TFS:MMS:19,DVER=$(DVER),ERBL=MFX:TFS:MMS:19:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TFS:MMS:21,PORT=smc-mfx-03:2111,ASYN=MFX:TFS:MMS:21,DVER=$(DVER),ERBL=MFX:TFS:MMS:21:LE:POSITIONGET" )





var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-mfx-tfs-ims/autosave" )

set_pass0_restoreFile( "ioc-mfx-tfs-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-mfx-tfs-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

