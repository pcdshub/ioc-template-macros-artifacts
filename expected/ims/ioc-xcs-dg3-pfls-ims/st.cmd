#!/reg/g/pcds/epics/ioc/common/ims/R6.0.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XCS:DG3:PFLS:IMS" )
epicsEnvSet( "LOCATION",             "XRT:DG3"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xcs-dg3-pfls-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Tyler Pennebaker (pennebak)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )




dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:DG3:MMS:19,PORT=moxa-xcs-04:4013,ASYN=XCS:DG3:MMS:19,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:DG3:PFLS:Y,STATE=PACK1,SET=5,DELTA=0.5,MOVER=XCS:DG3:MMS:19.VAL,RBV=XCS:DG3:MMS:19.RBV,DMOV=XCS:DG3:MMS:19.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:DG3:PFLS:Y,STATE=PACK2,SET=24,DELTA=0.5,MOVER=XCS:DG3:MMS:19.VAL,RBV=XCS:DG3:MMS:19.RBV,DMOV=XCS:DG3:MMS:19.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:DG3:PFLS:Y,STATE=PACK3,SET=43,DELTA=0.5,MOVER=XCS:DG3:MMS:19.VAL,RBV=XCS:DG3:MMS:19.RBV,DMOV=XCS:DG3:MMS:19.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:DG3:PFLS:Y,STATE=OUT,SET=56,DELTA=5.0,MOVER=XCS:DG3:MMS:19.VAL,RBV=XCS:DG3:MMS:19.RBV,DMOV=XCS:DG3:MMS:19.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=XCS:DG3:PFLS:Y,STATE1=PACK1,SEVR1=MINOR,STATE2=PACK2,SEVR2=MINOR,STATE3=PACK3,SEVR3=MINOR,STATE4=OUT,SEVR4=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:DG3:MMS:19,ALIAS=XCS:DG3:PFLS:Y:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:DG3:MMS:18,PORT=moxa-xcs-04:4012,ASYN=XCS:DG3:MMS:18,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:DG3:PFLS:X,STATE=PACK1,SET=0,DELTA=0.1,MOVER=XCS:DG3:MMS:18.VAL,RBV=XCS:DG3:MMS:18.RBV,DMOV=XCS:DG3:MMS:18.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:DG3:PFLS:X,STATE=PACK2,SET=0,DELTA=0.1,MOVER=XCS:DG3:MMS:18.VAL,RBV=XCS:DG3:MMS:18.RBV,DMOV=XCS:DG3:MMS:18.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:DG3:PFLS:X,STATE=PACK3,SET=0,DELTA=0.1,MOVER=XCS:DG3:MMS:18.VAL,RBV=XCS:DG3:MMS:18.RBV,DMOV=XCS:DG3:MMS:18.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:DG3:PFLS:X,STATE=OUT,SET=0,DELTA=1.0,MOVER=XCS:DG3:MMS:18.VAL,RBV=XCS:DG3:MMS:18.RBV,DMOV=XCS:DG3:MMS:18.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=XCS:DG3:PFLS:X,STATE1=PACK1,SEVR1=MINOR,STATE2=PACK2,SEVR2=MINOR,STATE3=PACK3,SEVR3=MINOR,STATE4=OUT,SEVR4=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:DG3:MMS:18,ALIAS=XCS:DG3:PFLS:X:MOTOR" )

dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XCS:DG3:PFLS,STATE=PACK1,COMP1=XCS:DG3:PFLS:Y,COMP2=XCS:DG3:PFLS:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XCS:DG3:PFLS,STATE=PACK2,COMP1=XCS:DG3:PFLS:Y,COMP2=XCS:DG3:PFLS:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XCS:DG3:PFLS,STATE=PACK3,COMP1=XCS:DG3:PFLS:Y,COMP2=XCS:DG3:PFLS:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XCS:DG3:PFLS,STATE=OUT,COMP1=XCS:DG3:PFLS:Y,COMP2=XCS:DG3:PFLS:X" )
dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=XCS:DG3:PFLS,STATE1=PACK1,SEVR1=MINOR,STATE2=PACK2,SEVR2=MINOR,STATE3=PACK3,SEVR3=MINOR,STATE4=OUT,SEVR4=NO_ALARM" )












var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xcs-dg3-pfls-ims/autosave" )

set_pass0_restoreFile( "ioc-xcs-dg3-pfls-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xcs-dg3-pfls-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

