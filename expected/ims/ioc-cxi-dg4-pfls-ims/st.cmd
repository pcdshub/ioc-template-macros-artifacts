#!/reg/g/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:CXI:DG4:PFLS:IMS" )
epicsEnvSet( "LOCATION",             "CXI:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-cxi-dg4-pfls-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Christian Tsoi-A-Sue (ctsoi)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME),P=$(EPICS_NAME):" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )




dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DG4:MMS:05,PORT=digi-cxi-07:2104,ASYN=CXI:DG4:MMS:05,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG4:PFLS:Y,STATE=6K70,SET=-54.10,DELTA=0.5,MOVER=CXI:DG4:MMS:05.VAL,RBV=CXI:DG4:MMS:05.RBV,DMOV=CXI:DG4:MMS:05.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG4:PFLS:Y,STATE=7K50,SET=-73.15,DELTA=0.5,MOVER=CXI:DG4:MMS:05.VAL,RBV=CXI:DG4:MMS:05.RBV,DMOV=CXI:DG4:MMS:05.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG4:PFLS:Y,STATE=9K45,SET=-92.20,DELTA=0.5,MOVER=CXI:DG4:MMS:05.VAL,RBV=CXI:DG4:MMS:05.RBV,DMOV=CXI:DG4:MMS:05.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG4:PFLS:Y,STATE=OUT,SET=56,DELTA=5.0,MOVER=CXI:DG4:MMS:05.VAL,RBV=CXI:DG4:MMS:05.RBV,DMOV=CXI:DG4:MMS:05.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=CXI:DG4:PFLS:Y,STATE1=6K70,SEVR1=MINOR,STATE2=7K50,SEVR2=MINOR,STATE3=9K45,SEVR3=MINOR,STATE4=OUT,SEVR4=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DG4:MMS:05,ALIAS=CXI:DG4:PFLS:Y:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DG4:MMS:04,PORT=digi-cxi-07:2103,ASYN=CXI:DG4:MMS:04,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG4:PFLS:X,STATE=6K70,SET=0,DELTA=0.1,MOVER=CXI:DG4:MMS:04.VAL,RBV=CXI:DG4:MMS:04.RBV,DMOV=CXI:DG4:MMS:04.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG4:PFLS:X,STATE=7K50,SET=0,DELTA=0.1,MOVER=CXI:DG4:MMS:04.VAL,RBV=CXI:DG4:MMS:04.RBV,DMOV=CXI:DG4:MMS:04.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG4:PFLS:X,STATE=9K45,SET=0,DELTA=0.1,MOVER=CXI:DG4:MMS:04.VAL,RBV=CXI:DG4:MMS:04.RBV,DMOV=CXI:DG4:MMS:04.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG4:PFLS:X,STATE=OUT,SET=0,DELTA=1.0,MOVER=CXI:DG4:MMS:04.VAL,RBV=CXI:DG4:MMS:04.RBV,DMOV=CXI:DG4:MMS:04.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=CXI:DG4:PFLS:X,STATE1=6K70,SEVR1=MINOR,STATE2=7K50,SEVR2=MINOR,STATE3=9K45,SEVR3=MINOR,STATE4=OUT,SEVR4=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DG4:MMS:04,ALIAS=CXI:DG4:PFLS:X:MOTOR" )

dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=CXI:DG4:PFLS,STATE=6K70,COMP1=CXI:DG4:PFLS:Y,COMP2=CXI:DG4:PFLS:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=CXI:DG4:PFLS,STATE=7K50,COMP1=CXI:DG4:PFLS:Y,COMP2=CXI:DG4:PFLS:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=CXI:DG4:PFLS,STATE=9K45,COMP1=CXI:DG4:PFLS:Y,COMP2=CXI:DG4:PFLS:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=CXI:DG4:PFLS,STATE=OUT,COMP1=CXI:DG4:PFLS:Y,COMP2=CXI:DG4:PFLS:X" )
dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=CXI:DG4:PFLS,STATE1=6K70,SEVR1=MINOR,STATE2=7K50,SEVR2=MINOR,STATE3=9K45,SEVR3=MINOR,STATE4=OUT,SEVR4=NO_ALARM" )












var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-cxi-dg4-pfls-ims/autosave" )

set_pass0_restoreFile( "ioc-cxi-dg4-pfls-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-cxi-dg4-pfls-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

