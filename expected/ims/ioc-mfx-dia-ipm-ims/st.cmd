#!/reg/g/pcds/epics/ioc/common/ims/R2.3.9/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:MFX:DIA:IPM:IMS" )
epicsEnvSet( "LOCATION",             "XRT:MFX:DIA"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-mfx-dia-ipm-ims> " )

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

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DIA:MMS:01,PORT=smc-mfx-06:2107,ASYN=MFX:DIA:MMS:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DIA:MMS:02,PORT=smc-mfx-06:2108,ASYN=MFX:DIA:MMS:02,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DIA:MMS:03,PORT=smc-mfx-06:2109,ASYN=MFX:DIA:MMS:03,DVER=$(DVER),ERBL=" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DIA:IPM:DIODE,STATE=IN,SET=0,DELTA=0.5,MOVER=MFX:DIA:MMS:02.VAL,RBV=MFX:DIA:MMS:02.RBV,DMOV=MFX:DIA:MMS:02.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DIA:IPM:DIODE,STATE=OUT,SET=-40,DELTA=5.0,MOVER=MFX:DIA:MMS:02.VAL,RBV=MFX:DIA:MMS:02.RBV,DMOV=MFX:DIA:MMS:02.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MFX:DIA:IPM:DIODE,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:DIA:MMS:02,ALIAS=MFX:DIA:IPM:DIODE:MOTOR" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:DIA:MMS:01,ALIAS=MFX:DIA:IPM:DIODE:X_MOTOR" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DIA:IPM:TARGET,STATE=TARGET1,SET=22,DELTA=0.5,MOVER=MFX:DIA:MMS:03.VAL,RBV=MFX:DIA:MMS:03.RBV,DMOV=MFX:DIA:MMS:03.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DIA:IPM:TARGET,STATE=TARGET2,SET=36,DELTA=0.5,MOVER=MFX:DIA:MMS:03.VAL,RBV=MFX:DIA:MMS:03.RBV,DMOV=MFX:DIA:MMS:03.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DIA:IPM:TARGET,STATE=TARGET3,SET=49.5,DELTA=0.5,MOVER=MFX:DIA:MMS:03.VAL,RBV=MFX:DIA:MMS:03.RBV,DMOV=MFX:DIA:MMS:03.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DIA:IPM:TARGET,STATE=TARGET4,SET=63,DELTA=0.5,MOVER=MFX:DIA:MMS:03.VAL,RBV=MFX:DIA:MMS:03.RBV,DMOV=MFX:DIA:MMS:03.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DIA:IPM:TARGET,STATE=OUT,SET=85,DELTA=5.0,MOVER=MFX:DIA:MMS:03.VAL,RBV=MFX:DIA:MMS:03.RBV,DMOV=MFX:DIA:MMS:03.DMOV" )

dbLoadRecords( "$(TOP)/db/device_with_5states.db", "DEVICE=MFX:DIA:IPM:TARGET,STATE1=TARGET1,SEVR1=MINOR,STATE2=TARGET2,SEVR2=MINOR,STATE3=TARGET3,SEVR3=MINOR,STATE4=TARGET4,SEVR4=MINOR,STATE5=OUT,SEVR5=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:DIA:MMS:03,ALIAS=MFX:DIA:IPM:TARGET:MOTOR" )















var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-mfx-dia-ipm-ims/autosave" )

set_pass0_restoreFile( "ioc-mfx-dia-ipm-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-mfx-dia-ipm-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

