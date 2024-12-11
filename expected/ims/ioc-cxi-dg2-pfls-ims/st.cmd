#!/reg/g/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:CXI:DG2:PFLS:IMS" )
epicsEnvSet( "LOCATION",             "CXI:DG2"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-cxi-dg2-pfls-ims> " )

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




dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DG2:MMS:06,PORT=moxa-cxi-04:4006,ASYN=CXI:DG2:MMS:06,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG2:PFLS:Y,STATE=PACK1,SET=-92.4343,DELTA=0.5,MOVER=CXI:DG2:MMS:06.VAL,RBV=CXI:DG2:MMS:06.RBV,DMOV=CXI:DG2:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG2:PFLS:Y,STATE=PACK2,SET=-73.15,DELTA=0.5,MOVER=CXI:DG2:MMS:06.VAL,RBV=CXI:DG2:MMS:06.RBV,DMOV=CXI:DG2:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG2:PFLS:Y,STATE=PACK3,SET=-54.1,DELTA=0.5,MOVER=CXI:DG2:MMS:06.VAL,RBV=CXI:DG2:MMS:06.RBV,DMOV=CXI:DG2:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG2:PFLS:Y,STATE=OUT,SET=-9,DELTA=10,MOVER=CXI:DG2:MMS:06.VAL,RBV=CXI:DG2:MMS:06.RBV,DMOV=CXI:DG2:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=CXI:DG2:PFLS:Y,STATE1=PACK1,SEVR1=MINOR,STATE2=PACK2,SEVR2=MINOR,STATE3=PACK3,SEVR3=MINOR,STATE4=OUT,SEVR4=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DG2:MMS:06,ALIAS=CXI:DG2:PFLS:Y:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DG2:MMS:05,PORT=moxa-cxi-04:4005,ASYN=CXI:DG2:MMS:05,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG2:PFLS:X,STATE=PACK1,SET=0,DELTA=0.1,MOVER=CXI:DG2:MMS:05.VAL,RBV=CXI:DG2:MMS:05.RBV,DMOV=CXI:DG2:MMS:05.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG2:PFLS:X,STATE=PACK2,SET=0,DELTA=0.1,MOVER=CXI:DG2:MMS:05.VAL,RBV=CXI:DG2:MMS:05.RBV,DMOV=CXI:DG2:MMS:05.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG2:PFLS:X,STATE=PACK3,SET=0,DELTA=0.1,MOVER=CXI:DG2:MMS:05.VAL,RBV=CXI:DG2:MMS:05.RBV,DMOV=CXI:DG2:MMS:05.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG2:PFLS:X,STATE=OUT,SET=0,DELTA=1.0,MOVER=CXI:DG2:MMS:05.VAL,RBV=CXI:DG2:MMS:05.RBV,DMOV=CXI:DG2:MMS:05.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=CXI:DG2:PFLS:X,STATE1=PACK1,SEVR1=MINOR,STATE2=PACK2,SEVR2=MINOR,STATE3=PACK3,SEVR3=MINOR,STATE4=OUT,SEVR4=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DG2:MMS:05,ALIAS=CXI:DG2:PFLS:X:MOTOR" )

dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=CXI:DG2:PFLS,STATE=PACK1,COMP1=CXI:DG2:PFLS:Y,COMP2=CXI:DG2:PFLS:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=CXI:DG2:PFLS,STATE=PACK2,COMP1=CXI:DG2:PFLS:Y,COMP2=CXI:DG2:PFLS:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=CXI:DG2:PFLS,STATE=PACK3,COMP1=CXI:DG2:PFLS:Y,COMP2=CXI:DG2:PFLS:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=CXI:DG2:PFLS,STATE=OUT,COMP1=CXI:DG2:PFLS:Y,COMP2=CXI:DG2:PFLS:X" )
dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=CXI:DG2:PFLS,STATE1=PACK1,SEVR1=MINOR,STATE2=PACK2,SEVR2=MINOR,STATE3=PACK3,SEVR3=MINOR,STATE4=OUT,SEVR4=NO_ALARM" )












var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-cxi-dg2-pfls-ims/autosave" )

set_pass0_restoreFile( "ioc-cxi-dg2-pfls-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-cxi-dg2-pfls-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

