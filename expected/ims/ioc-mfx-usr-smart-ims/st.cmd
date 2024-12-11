#!/reg/g/pcds/epics/ioc/common/ims/R2.3.9/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:MFX:USR:SMART:IMS" )
epicsEnvSet( "LOCATION",             "MFX:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-mfx-usr-smart-ims> " )

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











dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:USR:MMS:01,PORT=smc-mfx-05:2101,ASYN=MFX:USR:MMS:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:USR:MMS:02,PORT=smc-mfx-05:2102,ASYN=MFX:USR:MMS:02,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:USR:MMS:03,PORT=smc-mfx-05:2103,ASYN=MFX:USR:MMS:03,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:USR:MMS:04,PORT=smc-mfx-05:2104,ASYN=MFX:USR:MMS:04,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:USR:MMS:05,PORT=smc-mfx-05:2105,ASYN=MFX:USR:MMS:05,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:USR:MMS:06,PORT=smc-mfx-05:2106,ASYN=MFX:USR:MMS:06,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:USR:MMS:07,PORT=smc-mfx-05:2107,ASYN=MFX:USR:MMS:07,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:USR:MMS:08,PORT=smc-mfx-05:2108,ASYN=MFX:USR:MMS:08,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:USR:MMS:09,PORT=smc-mfx-05:2109,ASYN=MFX:USR:MMS:09,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:USR:MMS:10,PORT=smc-mfx-05:2110,ASYN=MFX:USR:MMS:10,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:USR:MMS:11,PORT=smc-mfx-05:2111,ASYN=MFX:USR:MMS:11,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:USR:MMS:12,PORT=smc-mfx-05:2112,ASYN=MFX:USR:MMS:12,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:USR:MMS:13,PORT=smc-mfx-05:2113,ASYN=MFX:USR:MMS:13,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:USR:MMS:14,PORT=smc-mfx-05:2114,ASYN=MFX:USR:MMS:14,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:USR:MMS:15,PORT=smc-mfx-05:2115,ASYN=MFX:USR:MMS:15,DVER=$(DVER),ERBL=" )





var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-mfx-usr-smart-ims/autosave" )

set_pass0_restoreFile( "ioc-mfx-usr-smart-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-mfx-usr-smart-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

