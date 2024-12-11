#!/reg/g/pcds/epics/ioc/common/ims/R6.0.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XCS:SB1:IPM:IMS" )
epicsEnvSet( "LOCATION",             "XCS:SB1"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xcs-sb1-ipm-ims> " )

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

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB1:MMS:07,PORT=moxa-xcs-02:4007,ASYN=XCS:SB1:MMS:07,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB1:MMS:06,PORT=moxa-xcs-02:4006,ASYN=XCS:SB1:MMS:06,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB1:MMS:08,PORT=moxa-xcs-02:4008,ASYN=XCS:SB1:MMS:08,DVER=$(DVER),ERBL=" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB1:IPM:DIODE,STATE=IN,SET=0,DELTA=0.9,MOVER=XCS:SB1:MMS:06.VAL,RBV=XCS:SB1:MMS:06.RBV,DMOV=XCS:SB1:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB1:IPM:DIODE,STATE=OUT,SET=-40,DELTA=0.5,MOVER=XCS:SB1:MMS:06.VAL,RBV=XCS:SB1:MMS:06.RBV,DMOV=XCS:SB1:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:SB1:IPM:DIODE,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB1:MMS:06,ALIAS=XCS:SB1:IPM:DIODE:MOTOR" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB1:MMS:07,ALIAS=XCS:SB1:IPM:DIODE:X_MOTOR" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB1:IPM:TARGET,STATE=TARGET1,SET=18.55,DELTA=0.5,MOVER=XCS:SB1:MMS:08.VAL,RBV=XCS:SB1:MMS:08.RBV,DMOV=XCS:SB1:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB1:IPM:TARGET,STATE=TARGET2,SET=32,DELTA=0.5,MOVER=XCS:SB1:MMS:08.VAL,RBV=XCS:SB1:MMS:08.RBV,DMOV=XCS:SB1:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB1:IPM:TARGET,STATE=TARGET3,SET=45.6,DELTA=0.5,MOVER=XCS:SB1:MMS:08.VAL,RBV=XCS:SB1:MMS:08.RBV,DMOV=XCS:SB1:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB1:IPM:TARGET,STATE=TARGET4,SET=59.,DELTA=0.5,MOVER=XCS:SB1:MMS:08.VAL,RBV=XCS:SB1:MMS:08.RBV,DMOV=XCS:SB1:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB1:IPM:TARGET,STATE=OUT,SET=0,DELTA=1.0,MOVER=XCS:SB1:MMS:08.VAL,RBV=XCS:SB1:MMS:08.RBV,DMOV=XCS:SB1:MMS:08.DMOV" )

dbLoadRecords( "$(TOP)/db/device_with_5states.db", "DEVICE=XCS:SB1:IPM:TARGET,STATE1=TARGET1,SEVR1=MINOR,STATE2=TARGET2,SEVR2=MINOR,STATE3=TARGET3,SEVR3=MINOR,STATE4=TARGET4,SEVR4=MINOR,STATE5=OUT,SEVR5=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB1:MMS:08,ALIAS=XCS:SB1:IPM:TARGET:MOTOR" )















var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xcs-sb1-ipm-ims/autosave" )

set_pass0_restoreFile( "ioc-xcs-sb1-ipm-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xcs-sb1-ipm-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

