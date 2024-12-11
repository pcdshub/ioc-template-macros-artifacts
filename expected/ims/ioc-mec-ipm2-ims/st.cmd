#!/reg/g/pcds/epics/ioc/common/ims/R6.0.0/bin/linux-x86/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:MEC:IPM2:IMS" )
epicsEnvSet( "LOCATION",             "MEC:R60:IOC:38"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-mec-ipm2-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Jing Yin (jyin)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:XT2:MMS:10,PORT=moxa-mec-03:4009,ASYN=MEC:XT2:MMS:10,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:XT2:MMS:11,PORT=moxa-mec-03:4010,ASYN=MEC:XT2:MMS:11,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:XT2:MMS:12,PORT=moxa-mec-03:4011,ASYN=MEC:XT2:MMS:12,DVER=$(DVER),ERBL=" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:IPM2:DIODE,STATE=IN,SET=0,DELTA=0.5,MOVER=MEC:XT2:MMS:11.VAL,RBV=MEC:XT2:MMS:11.RBV,DMOV=MEC:XT2:MMS:11.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:IPM2:DIODE,STATE=OUT,SET=-40,DELTA=5.0,MOVER=MEC:XT2:MMS:11.VAL,RBV=MEC:XT2:MMS:11.RBV,DMOV=MEC:XT2:MMS:11.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MEC:IPM2:DIODE,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:XT2:MMS:11,ALIAS=MEC:IPM2:DIODE:MOTOR" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:XT2:MMS:10,ALIAS=MEC:IPM2:DIODE:X_MOTOR" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:IPM2:TARGET,STATE=TARGET1,SET=22,DELTA=0.5,MOVER=MEC:XT2:MMS:12.VAL,RBV=MEC:XT2:MMS:12.RBV,DMOV=MEC:XT2:MMS:12.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:IPM2:TARGET,STATE=TARGET2,SET=36,DELTA=0.5,MOVER=MEC:XT2:MMS:12.VAL,RBV=MEC:XT2:MMS:12.RBV,DMOV=MEC:XT2:MMS:12.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:IPM2:TARGET,STATE=TARGET3,SET=49.5,DELTA=0.5,MOVER=MEC:XT2:MMS:12.VAL,RBV=MEC:XT2:MMS:12.RBV,DMOV=MEC:XT2:MMS:12.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:IPM2:TARGET,STATE=TARGET4,SET=63,DELTA=0.5,MOVER=MEC:XT2:MMS:12.VAL,RBV=MEC:XT2:MMS:12.RBV,DMOV=MEC:XT2:MMS:12.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:IPM2:TARGET,STATE=OUT,SET=85,DELTA=5.0,MOVER=MEC:XT2:MMS:12.VAL,RBV=MEC:XT2:MMS:12.RBV,DMOV=MEC:XT2:MMS:12.DMOV" )

dbLoadRecords( "$(TOP)/db/device_with_5states.db", "DEVICE=MEC:IPM2:TARGET,STATE1=TARGET1,SEVR1=MINOR,STATE2=TARGET2,SEVR2=MINOR,STATE3=TARGET3,SEVR3=MINOR,STATE4=TARGET4,SEVR4=MINOR,STATE5=OUT,SEVR5=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:XT2:MMS:12,ALIAS=MEC:IPM2:TARGET:MOTOR" )















var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-mec-ipm2-ims/autosave" )

set_pass0_restoreFile( "ioc-mec-ipm2-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-mec-ipm2-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

