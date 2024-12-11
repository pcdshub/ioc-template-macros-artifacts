#!/reg/g/pcds/epics/ioc/common/ims/R6.3.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XRT:HXX:UM6:IPM:IMS" )
epicsEnvSet( "LOCATION",             "XRT:UM6"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xrt-hxx-um6-ipm-ims> " )

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
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME),P=$(EPICS_NAME):" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HXX:UM6:MMS:06,PORT=moxa-xrt-um6-01:4006,ASYN=HXX:UM6:MMS:06,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HXX:UM6:MMS:07,PORT=moxa-xrt-um6-01:4007,ASYN=HXX:UM6:MMS:07,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HXX:UM6:MMS:05,PORT=moxa-xrt-um6-01:4005,ASYN=HXX:UM6:MMS:05,DVER=$(DVER),ERBL=" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HXX:UM6:IPM:DIODE,STATE=IN,SET=0,DELTA=0.9,MOVER=HXX:UM6:MMS:07.VAL,RBV=HXX:UM6:MMS:07.RBV,DMOV=HXX:UM6:MMS:07.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HXX:UM6:IPM:DIODE,STATE=OUT,SET=-40,DELTA=0.5,MOVER=HXX:UM6:MMS:07.VAL,RBV=HXX:UM6:MMS:07.RBV,DMOV=HXX:UM6:MMS:07.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=HXX:UM6:IPM:DIODE,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HXX:UM6:MMS:07,ALIAS=HXX:UM6:IPM:DIODE:MOTOR" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HXX:UM6:MMS:06,ALIAS=HXX:UM6:IPM:DIODE:X_MOTOR" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HXX:UM6:IPM:TARGET,STATE=TARGET1,SET=17.5,DELTA=0.5,MOVER=HXX:UM6:MMS:05.VAL,RBV=HXX:UM6:MMS:05.RBV,DMOV=HXX:UM6:MMS:05.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HXX:UM6:IPM:TARGET,STATE=TARGET2,SET=31,DELTA=0.5,MOVER=HXX:UM6:MMS:05.VAL,RBV=HXX:UM6:MMS:05.RBV,DMOV=HXX:UM6:MMS:05.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HXX:UM6:IPM:TARGET,STATE=TARGET3,SET=44.5,DELTA=0.5,MOVER=HXX:UM6:MMS:05.VAL,RBV=HXX:UM6:MMS:05.RBV,DMOV=HXX:UM6:MMS:05.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HXX:UM6:IPM:TARGET,STATE=TARGET4,SET=58,DELTA=0.5,MOVER=HXX:UM6:MMS:05.VAL,RBV=HXX:UM6:MMS:05.RBV,DMOV=HXX:UM6:MMS:05.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HXX:UM6:IPM:TARGET,STATE=OUT,SET=0,DELTA=1.0,MOVER=HXX:UM6:MMS:05.VAL,RBV=HXX:UM6:MMS:05.RBV,DMOV=HXX:UM6:MMS:05.DMOV" )

dbLoadRecords( "$(TOP)/db/device_with_5states.db", "DEVICE=HXX:UM6:IPM:TARGET,STATE1=TARGET1,SEVR1=MINOR,STATE2=TARGET2,SEVR2=MINOR,STATE3=TARGET3,SEVR3=MINOR,STATE4=TARGET4,SEVR4=MINOR,STATE5=OUT,SEVR5=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HXX:UM6:MMS:05,ALIAS=HXX:UM6:IPM:TARGET:MOTOR" )















var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xrt-hxx-um6-ipm-ims/autosave" )

set_pass0_restoreFile( "ioc-xrt-hxx-um6-ipm-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xrt-hxx-um6-ipm-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

