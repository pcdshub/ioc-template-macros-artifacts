#!/reg/g/pcds/epics/ioc/common/ims/R6.0.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XCS:SB2:IPM:IMS" )
epicsEnvSet( "LOCATION",             "XCS:SB2"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xcs-sb2-ipm-ims> " )

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

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB2:MMS:40,PORT=digi-xcs-11:2112,ASYN=XCS:SB2:MMS:40,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB2:MMS:39,PORT=digi-xcs-11:2114,ASYN=XCS:SB2:MMS:39,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB2:MMS:41,PORT=digi-xcs-11:2113,ASYN=XCS:SB2:MMS:41,DVER=$(DVER),ERBL=" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:IPM:DIODE,STATE=IN,SET=0,DELTA=0.9,MOVER=XCS:SB2:MMS:39.VAL,RBV=XCS:SB2:MMS:39.RBV,DMOV=XCS:SB2:MMS:39.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:IPM:DIODE,STATE=OUT,SET=-40,DELTA=0.5,MOVER=XCS:SB2:MMS:39.VAL,RBV=XCS:SB2:MMS:39.RBV,DMOV=XCS:SB2:MMS:39.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:SB2:IPM:DIODE,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB2:MMS:39,ALIAS=XCS:SB2:IPM:DIODE:MOTOR" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB2:MMS:40,ALIAS=XCS:SB2:IPM:DIODE:X_MOTOR" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:IPM:TARGET,STATE=TARGET1,SET=18.25,DELTA=0.5,MOVER=XCS:SB2:MMS:41.VAL,RBV=XCS:SB2:MMS:41.RBV,DMOV=XCS:SB2:MMS:41.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:IPM:TARGET,STATE=TARGET2,SET=32,DELTA=0.5,MOVER=XCS:SB2:MMS:41.VAL,RBV=XCS:SB2:MMS:41.RBV,DMOV=XCS:SB2:MMS:41.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:IPM:TARGET,STATE=TARGET3,SET=45.35,DELTA=0.5,MOVER=XCS:SB2:MMS:41.VAL,RBV=XCS:SB2:MMS:41.RBV,DMOV=XCS:SB2:MMS:41.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:IPM:TARGET,STATE=TARGET4,SET=58.799,DELTA=0.5,MOVER=XCS:SB2:MMS:41.VAL,RBV=XCS:SB2:MMS:41.RBV,DMOV=XCS:SB2:MMS:41.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:IPM:TARGET,STATE=OUT,SET=0,DELTA=1.0,MOVER=XCS:SB2:MMS:41.VAL,RBV=XCS:SB2:MMS:41.RBV,DMOV=XCS:SB2:MMS:41.DMOV" )

dbLoadRecords( "$(TOP)/db/device_with_5states.db", "DEVICE=XCS:SB2:IPM:TARGET,STATE1=TARGET1,SEVR1=MINOR,STATE2=TARGET2,SEVR2=MINOR,STATE3=TARGET3,SEVR3=MINOR,STATE4=TARGET4,SEVR4=MINOR,STATE5=OUT,SEVR5=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB2:MMS:41,ALIAS=XCS:SB2:IPM:TARGET:MOTOR" )















var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xcs-sb2-ipm-ims/autosave" )

set_pass0_restoreFile( "ioc-xcs-sb2-ipm-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xcs-sb2-ipm-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
