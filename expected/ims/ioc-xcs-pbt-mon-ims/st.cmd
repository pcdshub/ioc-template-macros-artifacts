#!/reg/g/pcds/epics/ioc/common/ims/R6.0.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XCS:PBT:MON:IMS" )
epicsEnvSet( "LOCATION",             "XRT:S80"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xcs-pbt-mon-ims> " )

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










dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:MON:MMS:32,PORT=moxa-xcs-07:4012,ASYN=XCS:MON:MMS:32,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:MON:DSCAM,STATE=IN,SET=25,DELTA=0.5,MOVER=XCS:MON:MMS:32.VAL,RBV=XCS:MON:MMS:32.RBV,DMOV=XCS:MON:MMS:32.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:MON:DSCAM,STATE=OUT,SET=0,DELTA=0.5,MOVER=XCS:MON:MMS:32.VAL,RBV=XCS:MON:MMS:32.RBV,DMOV=XCS:MON:MMS:32.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:MON:DSCAM,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:MON:MMS:32,ALIAS=XCS:MON:DSCAM:MOTOR" )






var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xcs-pbt-mon-ims/autosave" )

set_pass0_restoreFile( "ioc-xcs-pbt-mon-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xcs-pbt-mon-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

