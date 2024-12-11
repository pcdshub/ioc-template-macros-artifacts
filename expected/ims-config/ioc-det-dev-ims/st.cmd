#!/reg/g/pcds/package/epics/3.14/ioc/common/ims/R2.1.0/bin/linux-x86/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:DET:DEV:IMS" )
epicsEnvSet( "LOCATION",             "DET"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-det-dev-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Scott Stubbs (sstubbs)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )

dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )


dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=DET:DEV:MMS:01,PORT=mcc-det-01:2101,ASYN=DET:DEV:MMS:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=DET:DEV:MMS:02,PORT=mcc-det-01:2103,ASYN=DET:DEV:MMS:02,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=DET:DEV:MMS:03,PORT=mcc-det-01:2104,ASYN=DET:DEV:MMS:03,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=DET:DEV:MMS:04,PORT=mcc-det-01:2105,ASYN=DET:DEV:MMS:04,DVER=$(DVER),ERBL=" )





var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-det-dev-ims/autosave" )

set_pass0_restoreFile( "ioc-det-dev-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-det-dev-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

