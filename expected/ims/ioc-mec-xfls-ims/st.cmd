#!/reg/g/pcds/epics/ioc/common/ims/R6.0.0/bin/linux-x86/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:MEC:XFLS:IMS" )
epicsEnvSet( "LOCATION",             "MEC:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-mec-xfls-ims> " )

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





dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:XT2:MMS:14,PORT=moxa-mec-03:4013,ASYN=MEC:XT2:MMS:14,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:XT2:MMS:15,PORT=moxa-mec-03:4014,ASYN=MEC:XT2:MMS:15,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:XT2:MMS:30,PORT=digi-mec-03:2104,ASYN=MEC:XT2:MMS:30,DVER=$(DVER),ERBL=" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:XT2:XFLS,STATE=PACK1,SET=0,DELTA=0.5,MOVER=MEC:XT2:MMS:15.VAL,RBV=MEC:XT2:MMS:15.RBV,DMOV=MEC:XT2:MMS:15.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:XT2:XFLS,STATE=PACK2,SET=16,DELTA=0.5,MOVER=MEC:XT2:MMS:15.VAL,RBV=MEC:XT2:MMS:15.RBV,DMOV=MEC:XT2:MMS:15.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:XT2:XFLS,STATE=PACK3,SET=30,DELTA=0.5,MOVER=MEC:XT2:MMS:15.VAL,RBV=MEC:XT2:MMS:15.RBV,DMOV=MEC:XT2:MMS:15.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:XT2:XFLS,STATE=OUT,SET=56,DELTA=5.0,MOVER=MEC:XT2:MMS:15.VAL,RBV=MEC:XT2:MMS:15.RBV,DMOV=MEC:XT2:MMS:15.DMOV" )

dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=MEC:XT2:XFLS,STATE1=PACK1,SEVR1=MINOR,STATE2=PACK2,SEVR2=MINOR,STATE3=PACK3,SEVR3=MINOR,STATE4=OUT,SEVR4=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:XT2:MMS:14,ALIAS=MEC:XT2:XFLS:X:MOTOR" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:XT2:MMS:15,ALIAS=MEC:XT2:XFLS:Y:MOTOR" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:XT2:MMS:30,ALIAS=MEC:XT2:XFLS:Z:MOTOR" )











var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-mec-xfls-ims/autosave" )

set_pass0_restoreFile( "ioc-mec-xfls-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-mec-xfls-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

