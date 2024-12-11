#!/reg/g/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XPP:SB3:IPM01:IMS" )
epicsEnvSet( "LOCATION",             "XPP:SB3"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xpp-sb3-ipm01-ims> " )

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

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB3:MMS:12,PORT=digi-xpp-07:2110,ASYN=XPP:SB3:MMS:12,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB3:MMS:11,PORT=digi-xpp-07:2109,ASYN=XPP:SB3:MMS:11,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB3:MMS:13,PORT=digi-xpp-07:2111,ASYN=XPP:SB3:MMS:13,DVER=$(DVER),ERBL=" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:SB3:IPM:DIODE,STATE=IN,SET=0,DELTA=0.5,MOVER=XPP:SB3:MMS:11.VAL,RBV=XPP:SB3:MMS:11.RBV,DMOV=XPP:SB3:MMS:11.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:SB3:IPM:DIODE,STATE=OUT,SET=-40,DELTA=5.0,MOVER=XPP:SB3:MMS:11.VAL,RBV=XPP:SB3:MMS:11.RBV,DMOV=XPP:SB3:MMS:11.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XPP:SB3:IPM:DIODE,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:SB3:MMS:11,ALIAS=XPP:SB3:IPM:DIODE:MOTOR" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:SB3:MMS:12,ALIAS=XPP:SB3:IPM:DIODE:X_MOTOR" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:SB3:IPM:TARGET,STATE=TARGET1,SET=22,DELTA=0.5,MOVER=XPP:SB3:MMS:13.VAL,RBV=XPP:SB3:MMS:13.RBV,DMOV=XPP:SB3:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:SB3:IPM:TARGET,STATE=TARGET2,SET=36,DELTA=0.5,MOVER=XPP:SB3:MMS:13.VAL,RBV=XPP:SB3:MMS:13.RBV,DMOV=XPP:SB3:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:SB3:IPM:TARGET,STATE=TARGET3,SET=49.5,DELTA=0.5,MOVER=XPP:SB3:MMS:13.VAL,RBV=XPP:SB3:MMS:13.RBV,DMOV=XPP:SB3:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:SB3:IPM:TARGET,STATE=TARGET4,SET=63,DELTA=0.5,MOVER=XPP:SB3:MMS:13.VAL,RBV=XPP:SB3:MMS:13.RBV,DMOV=XPP:SB3:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:SB3:IPM:TARGET,STATE=OUT,SET=56,DELTA=5.0,MOVER=XPP:SB3:MMS:13.VAL,RBV=XPP:SB3:MMS:13.RBV,DMOV=XPP:SB3:MMS:13.DMOV" )

dbLoadRecords( "$(TOP)/db/device_with_5states.db", "DEVICE=XPP:SB3:IPM:TARGET,STATE1=TARGET1,SEVR1=MINOR,STATE2=TARGET2,SEVR2=MINOR,STATE3=TARGET3,SEVR3=MINOR,STATE4=TARGET4,SEVR4=MINOR,STATE5=OUT,SEVR5=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:SB3:MMS:13,ALIAS=XPP:SB3:IPM:TARGET:MOTOR" )















var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xpp-sb3-ipm01-ims/autosave" )

set_pass0_restoreFile( "ioc-xpp-sb3-ipm01-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xpp-sb3-ipm01-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

