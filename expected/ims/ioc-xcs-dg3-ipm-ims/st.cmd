#!/reg/g/pcds/epics/ioc/common/ims/R6.0.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XCS:DG3:IPM:IMS" )
epicsEnvSet( "LOCATION",             "XCS:DG3"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xcs-dg3-ipm-ims> " )

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
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:DG3:MMS:15,PORT=moxa-xcs-04:4007,ASYN=XCS:DG3:MMS:15,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:DG3:MMS:14,PORT=moxa-xcs-04:4006,ASYN=XCS:DG3:MMS:14,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:DG3:MMS:16,PORT=moxa-xcs-04:4008,ASYN=XCS:DG3:MMS:16,DVER=$(DVER),ERBL=" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:DG3:IPM:DIODE,STATE=IN,SET=0,DELTA=0.9,MOVER=XCS:DG3:MMS:14.VAL,RBV=XCS:DG3:MMS:14.RBV,DMOV=XCS:DG3:MMS:14.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:DG3:IPM:DIODE,STATE=OUT,SET=-40,DELTA=0.5,MOVER=XCS:DG3:MMS:14.VAL,RBV=XCS:DG3:MMS:14.RBV,DMOV=XCS:DG3:MMS:14.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:DG3:IPM:DIODE,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:DG3:MMS:14,ALIAS=XCS:DG3:IPM:DIODE:MOTOR" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:DG3:MMS:15,ALIAS=XCS:DG3:IPM:DIODE:X_MOTOR" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:DG3:IPM:TARGET,STATE=TARGET1,SET=22.1,DELTA=0.5,MOVER=XCS:DG3:MMS:16.VAL,RBV=XCS:DG3:MMS:16.RBV,DMOV=XCS:DG3:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:DG3:IPM:TARGET,STATE=TARGET2,SET=35.75,DELTA=0.5,MOVER=XCS:DG3:MMS:16.VAL,RBV=XCS:DG3:MMS:16.RBV,DMOV=XCS:DG3:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:DG3:IPM:TARGET,STATE=TARGET3,SET=49.2,DELTA=0.5,MOVER=XCS:DG3:MMS:16.VAL,RBV=XCS:DG3:MMS:16.RBV,DMOV=XCS:DG3:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:DG3:IPM:TARGET,STATE=TARGET4,SET=62.6,DELTA=0.5,MOVER=XCS:DG3:MMS:16.VAL,RBV=XCS:DG3:MMS:16.RBV,DMOV=XCS:DG3:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:DG3:IPM:TARGET,STATE=OUT,SET=0,DELTA=1.0,MOVER=XCS:DG3:MMS:16.VAL,RBV=XCS:DG3:MMS:16.RBV,DMOV=XCS:DG3:MMS:16.DMOV" )

dbLoadRecords( "$(TOP)/db/device_with_5states.db", "DEVICE=XCS:DG3:IPM:TARGET,STATE1=TARGET1,SEVR1=MINOR,STATE2=TARGET2,SEVR2=MINOR,STATE3=TARGET3,SEVR3=MINOR,STATE4=TARGET4,SEVR4=MINOR,STATE5=OUT,SEVR5=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:DG3:MMS:16,ALIAS=XCS:DG3:IPM:TARGET:MOTOR" )















var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xcs-dg3-ipm-ims/autosave" )

set_pass0_restoreFile( "ioc-xcs-dg3-ipm-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xcs-dg3-ipm-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

