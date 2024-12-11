#!/reg/g/pcds/epics/ioc/common/ims/R6.3.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XRT:MEC:XFLS:IMS" )
epicsEnvSet( "LOCATION",             "XRT:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xrt-mec-xfls-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Peregrine McGehee (peregrin)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME),P=$(EPICS_NAME):" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )




dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:HXM:MMS:02,PORT=moxa-xrt-mec06:4002,ASYN=MEC:HXM:MMS:02,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:HXM:XFLS:Y,STATE=PACK1,SET=5,DELTA=0.5,MOVER=MEC:HXM:MMS:02.VAL,RBV=MEC:HXM:MMS:02.RBV,DMOV=MEC:HXM:MMS:02.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:HXM:XFLS:Y,STATE=PACK2,SET=24,DELTA=0.5,MOVER=MEC:HXM:MMS:02.VAL,RBV=MEC:HXM:MMS:02.RBV,DMOV=MEC:HXM:MMS:02.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:HXM:XFLS:Y,STATE=PACK3,SET=43,DELTA=0.5,MOVER=MEC:HXM:MMS:02.VAL,RBV=MEC:HXM:MMS:02.RBV,DMOV=MEC:HXM:MMS:02.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:HXM:XFLS:Y,STATE=OUT,SET=56,DELTA=5.0,MOVER=MEC:HXM:MMS:02.VAL,RBV=MEC:HXM:MMS:02.RBV,DMOV=MEC:HXM:MMS:02.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=MEC:HXM:XFLS:Y,STATE1=PACK1,SEVR1=MINOR,STATE2=PACK2,SEVR2=MINOR,STATE3=PACK3,SEVR3=MINOR,STATE4=OUT,SEVR4=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:HXM:MMS:02,ALIAS=MEC:HXM:XFLS:Y:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:HXM:MMS:01,PORT=moxa-xrt-mec06:4001,ASYN=MEC:HXM:MMS:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:HXM:XFLS:X,STATE=PACK1,SET=0,DELTA=0.1,MOVER=MEC:HXM:MMS:01.VAL,RBV=MEC:HXM:MMS:01.RBV,DMOV=MEC:HXM:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:HXM:XFLS:X,STATE=PACK2,SET=0,DELTA=0.1,MOVER=MEC:HXM:MMS:01.VAL,RBV=MEC:HXM:MMS:01.RBV,DMOV=MEC:HXM:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:HXM:XFLS:X,STATE=PACK3,SET=0,DELTA=0.1,MOVER=MEC:HXM:MMS:01.VAL,RBV=MEC:HXM:MMS:01.RBV,DMOV=MEC:HXM:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:HXM:XFLS:X,STATE=OUT,SET=0,DELTA=1.0,MOVER=MEC:HXM:MMS:01.VAL,RBV=MEC:HXM:MMS:01.RBV,DMOV=MEC:HXM:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=MEC:HXM:XFLS:X,STATE1=PACK1,SEVR1=MINOR,STATE2=PACK2,SEVR2=MINOR,STATE3=PACK3,SEVR3=MINOR,STATE4=OUT,SEVR4=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:HXM:MMS:01,ALIAS=MEC:HXM:XFLS:X:MOTOR" )

dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=MEC:HXM:XFLS,STATE=PACK1,COMP1=MEC:HXM:XFLS:Y,COMP2=MEC:HXM:XFLS:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=MEC:HXM:XFLS,STATE=PACK2,COMP1=MEC:HXM:XFLS:Y,COMP2=MEC:HXM:XFLS:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=MEC:HXM:XFLS,STATE=PACK3,COMP1=MEC:HXM:XFLS:Y,COMP2=MEC:HXM:XFLS:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=MEC:HXM:XFLS,STATE=OUT,COMP1=MEC:HXM:XFLS:Y,COMP2=MEC:HXM:XFLS:X" )
dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=MEC:HXM:XFLS,STATE1=PACK1,SEVR1=MINOR,STATE2=PACK2,SEVR2=MINOR,STATE3=PACK3,SEVR3=MINOR,STATE4=OUT,SEVR4=NO_ALARM" )







dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:HXM:MMS:03,PORT=moxa-xrt-mec06:4003,ASYN=MEC:HXM:MMS:03,DVER=$(DVER),ERBL=" )





var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xrt-mec-xfls-ims/autosave" )

set_pass0_restoreFile( "ioc-xrt-mec-xfls-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xrt-mec-xfls-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

