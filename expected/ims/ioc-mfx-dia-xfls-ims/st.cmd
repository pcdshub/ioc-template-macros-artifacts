#!/reg/g/pcds/epics/ioc/common/ims/R2.3.9/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:MFX:DIA:XFLS:IMS" )
epicsEnvSet( "LOCATION",             "XRT:MFX:DIA"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-mfx-dia-xfls-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Alex Batyuk (batyuk)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )





dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DIA:MMS:08,PORT=smc-mfx-06:2104,ASYN=MFX:DIA:MMS:08,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DIA:MMS:09,PORT=smc-mfx-06:2105,ASYN=MFX:DIA:MMS:09,DVER=$(DVER),ERBL=" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DIA:XFLS:Y,STATE=6K70,SET=5,DELTA=0.5,MOVER=MFX:DIA:MMS:09.VAL,RBV=MFX:DIA:MMS:09.RBV,DMOV=MFX:DIA:MMS:09.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DIA:XFLS:Y,STATE=7K50,SET=24,DELTA=0.5,MOVER=MFX:DIA:MMS:09.VAL,RBV=MFX:DIA:MMS:09.RBV,DMOV=MFX:DIA:MMS:09.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DIA:XFLS:Y,STATE=9K45,SET=43,DELTA=0.5,MOVER=MFX:DIA:MMS:09.VAL,RBV=MFX:DIA:MMS:09.RBV,DMOV=MFX:DIA:MMS:09.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DIA:XFLS:Y,STATE=OUT,SET=56,DELTA=5.0,MOVER=MFX:DIA:MMS:09.VAL,RBV=MFX:DIA:MMS:09.RBV,DMOV=MFX:DIA:MMS:09.DMOV" )

dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=MFX:DIA:XFLS:Y,STATE1=6K70,SEVR1=MINOR,STATE2=7K50,SEVR2=MINOR,STATE3=9K45,SEVR3=MINOR,STATE4=OUT,SEVR4=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:DIA:MMS:08,ALIAS=MFX:DIA:XFLS:Y:X:MOTOR" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:DIA:MMS:09,ALIAS=MFX:DIA:XFLS:Y:Y:MOTOR" )








dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DIA:XFLS:X,STATE=OUT,SET=0,DELTA=0.5,MOVER=MFX:DIA:MMS:08.VAL,RBV=MFX:DIA:MMS:08.RBV,DMOV=MFX:DIA:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DIA:XFLS:X,STATE=6K70,SET=0,DELTA=0.5,MOVER=MFX:DIA:MMS:08.VAL,RBV=MFX:DIA:MMS:08.RBV,DMOV=MFX:DIA:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DIA:XFLS:X,STATE=7K50,SET=0,DELTA=0.5,MOVER=MFX:DIA:MMS:08.VAL,RBV=MFX:DIA:MMS:08.RBV,DMOV=MFX:DIA:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DIA:XFLS:X,STATE=9K45,SET=0,DELTA=0.5,MOVER=MFX:DIA:MMS:08.VAL,RBV=MFX:DIA:MMS:08.RBV,DMOV=MFX:DIA:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=MFX:DIA:XFLS:X,STATE1=OUT,SEVR1=NO_ALARM,STATE2=6K70,SEVR2=NO_ALARM,STATE3=7K50,SEVR3=NO_ALARM,STATE4=9K45,SEVR4=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:DIA:MMS:08,ALIAS=MFX:DIA:XFLS:X:MOTOR" )

dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=MFX:DIA:XFLS,STATE=6K70,COMP1=MFX:DIA:XFLS:X,COMP2=MFX:DIA:XFLS:Y" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=MFX:DIA:XFLS,STATE=7K50,COMP1=MFX:DIA:XFLS:X,COMP2=MFX:DIA:XFLS:Y" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=MFX:DIA:XFLS,STATE=9K45,COMP1=MFX:DIA:XFLS:X,COMP2=MFX:DIA:XFLS:Y" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=MFX:DIA:XFLS,STATE=OUT,COMP1=MFX:DIA:XFLS:X,COMP2=MFX:DIA:XFLS:Y" )
dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=MFX:DIA:XFLS,STATE1=6K70,SEVR1=NO_ALARM,STATE2=7K50,SEVR2=NO_ALARM,STATE3=9K45,SEVR3=NO_ALARM,STATE4=OUT,SEVR4=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=,ALIAS=MFX:DIA:XFLS:MOTOR" )


var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-mfx-dia-xfls-ims/autosave" )

set_pass0_restoreFile( "ioc-mfx-dia-xfls-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-mfx-dia-xfls-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

