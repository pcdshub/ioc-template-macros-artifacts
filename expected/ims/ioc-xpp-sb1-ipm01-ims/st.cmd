#!/reg/g/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XPP:SB1:IPM01:IMS" )
epicsEnvSet( "LOCATION",             "XPP:SB1"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xpp-sb1-ipm01-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Ali Sabbah (sabbah01)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME),P=$(EPICS_NAME):" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HX2:SB1:MMS:07,PORT=moxa-xpp-05:4007,ASYN=HX2:SB1:MMS:07,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HX2:SB1:MMS:06,PORT=moxa-xpp-05:4006,ASYN=HX2:SB1:MMS:06,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HX2:SB1:MMS:08,PORT=moxa-xpp-05:4008,ASYN=HX2:SB1:MMS:08,DVER=$(DVER),ERBL=" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HX2:SB1:IPM:DIODE,STATE=IN,SET=0,DELTA=0.5,MOVER=HX2:SB1:MMS:06.VAL,RBV=HX2:SB1:MMS:06.RBV,DMOV=HX2:SB1:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HX2:SB1:IPM:DIODE,STATE=OUT,SET=-40,DELTA=5.0,MOVER=HX2:SB1:MMS:06.VAL,RBV=HX2:SB1:MMS:06.RBV,DMOV=HX2:SB1:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=HX2:SB1:IPM:DIODE,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HX2:SB1:MMS:06,ALIAS=HX2:SB1:IPM:DIODE:MOTOR" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HX2:SB1:MMS:07,ALIAS=HX2:SB1:IPM:DIODE:X_MOTOR" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HX2:SB1:IPM:TARGET,STATE=TARGET1,SET=22,DELTA=0.5,MOVER=HX2:SB1:MMS:08.VAL,RBV=HX2:SB1:MMS:08.RBV,DMOV=HX2:SB1:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HX2:SB1:IPM:TARGET,STATE=TARGET2,SET=36,DELTA=0.5,MOVER=HX2:SB1:MMS:08.VAL,RBV=HX2:SB1:MMS:08.RBV,DMOV=HX2:SB1:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HX2:SB1:IPM:TARGET,STATE=TARGET3,SET=49.5,DELTA=0.5,MOVER=HX2:SB1:MMS:08.VAL,RBV=HX2:SB1:MMS:08.RBV,DMOV=HX2:SB1:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HX2:SB1:IPM:TARGET,STATE=TARGET4,SET=63,DELTA=0.5,MOVER=HX2:SB1:MMS:08.VAL,RBV=HX2:SB1:MMS:08.RBV,DMOV=HX2:SB1:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HX2:SB1:IPM:TARGET,STATE=OUT,SET=85,DELTA=5.0,MOVER=HX2:SB1:MMS:08.VAL,RBV=HX2:SB1:MMS:08.RBV,DMOV=HX2:SB1:MMS:08.DMOV" )

dbLoadRecords( "$(TOP)/db/device_with_5states.db", "DEVICE=HX2:SB1:IPM:TARGET,STATE1=TARGET1,SEVR1=MINOR,STATE2=TARGET2,SEVR2=MINOR,STATE3=TARGET3,SEVR3=MINOR,STATE4=TARGET4,SEVR4=MINOR,STATE5=OUT,SEVR5=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HX2:SB1:MMS:08,ALIAS=HX2:SB1:IPM:TARGET:MOTOR" )















var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xpp-sb1-ipm01-ims/autosave" )

set_pass0_restoreFile( "ioc-xpp-sb1-ipm01-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xpp-sb1-ipm01-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

