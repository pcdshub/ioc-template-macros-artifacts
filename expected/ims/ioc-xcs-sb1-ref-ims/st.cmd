#!/reg/g/pcds/epics/ioc/common/ims/R6.0.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XCS:SB1:REF:IMS" )
epicsEnvSet( "LOCATION",             "XCS:SB1"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xcs-sb1-ref-ims> " )

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








dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB1:MMS:13,PORT=moxa-xcs-02:4013,ASYN=XCS:SB1:MMS:13,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB1:RLM:MIRROR,STATE=IN,SET=50,DELTA=0.5,MOVER=XCS:SB1:MMS:13.VAL,RBV=XCS:SB1:MMS:13.RBV,DMOV=XCS:SB1:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB1:RLM:MIRROR,STATE=OUT,SET=0,DELTA=5.0,MOVER=XCS:SB1:MMS:13.VAL,RBV=XCS:SB1:MMS:13.RBV,DMOV=XCS:SB1:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:SB1:RLM:MIRROR,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB1:MMS:13,ALIAS=XCS:SB1:RLM:MIRROR:MOTOR" )








var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xcs-sb1-ref-ims/autosave" )

set_pass0_restoreFile( "ioc-xcs-sb1-ref-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xcs-sb1-ref-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

