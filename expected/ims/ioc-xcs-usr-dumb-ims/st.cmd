#!/reg/g/pcds/epics/ioc/common/ims/R6.0.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XCS:USR:DUMB:IMS" )
epicsEnvSet( "LOCATION",             "XCS:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xcs-usr-dumb-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Rajan Plumley (rajan-01)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )











dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:17,PORT=digi-xcs-17:2101,ASYN=XCS:USR:MMS:17,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:18,PORT=digi-xcs-17:2102,ASYN=XCS:USR:MMS:18,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:19,PORT=digi-xcs-17:2103,ASYN=XCS:USR:MMS:19,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:20,PORT=digi-xcs-17:2104,ASYN=XCS:USR:MMS:20,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:21,PORT=digi-xcs-17:2105,ASYN=XCS:USR:MMS:21,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:22,PORT=digi-xcs-17:2106,ASYN=XCS:USR:MMS:22,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:23,PORT=digi-xcs-17:2107,ASYN=XCS:USR:MMS:23,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:24,PORT=digi-xcs-17:2108,ASYN=XCS:USR:MMS:24,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:25,PORT=digi-xcs-17:2109,ASYN=XCS:USR:MMS:25,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:26,PORT=digi-xcs-17:2110,ASYN=XCS:USR:MMS:26,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:27,PORT=digi-xcs-17:2111,ASYN=XCS:USR:MMS:27,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:28,PORT=digi-xcs-17:2112,ASYN=XCS:USR:MMS:28,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:29,PORT=digi-xcs-17:2113,ASYN=XCS:USR:MMS:29,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:30,PORT=digi-xcs-17:2114,ASYN=XCS:USR:MMS:30,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:31,PORT=digi-xcs-17:2115,ASYN=XCS:USR:MMS:31,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:32,PORT=digi-xcs-17:2116,ASYN=XCS:USR:MMS:32,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:33,PORT=mcc-xcs-01:2101,ASYN=XCS:USR:MMS:33,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:34,PORT=mcc-xcs-01:2102,ASYN=XCS:USR:MMS:34,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:35,PORT=mcc-xcs-01:2103,ASYN=XCS:USR:MMS:35,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:36,PORT=mcc-xcs-01:2104,ASYN=XCS:USR:MMS:36,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:37,PORT=mcc-xcs-01:2105,ASYN=XCS:USR:MMS:37,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:38,PORT=mcc-xcs-01:2106,ASYN=XCS:USR:MMS:38,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:39,PORT=mcc-xcs-01:2107,ASYN=XCS:USR:MMS:39,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:40,PORT=mcc-xcs-01:2108,ASYN=XCS:USR:MMS:40,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:41,PORT=mcc-xcs-02:2101,ASYN=XCS:USR:MMS:41,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:42,PORT=mcc-xcs-02:2102,ASYN=XCS:USR:MMS:42,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:43,PORT=mcc-xcs-02:2103,ASYN=XCS:USR:MMS:43,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:44,PORT=mcc-xcs-02:2104,ASYN=XCS:USR:MMS:44,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:45,PORT=mcc-xcs-02:2105,ASYN=XCS:USR:MMS:45,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:46,PORT=mcc-xcs-02:2106,ASYN=XCS:USR:MMS:46,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:47,PORT=mcc-xcs-02:2107,ASYN=XCS:USR:MMS:47,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:USR:MMS:48,PORT=mcc-xcs-02:2108,ASYN=XCS:USR:MMS:48,DVER=$(DVER),ERBL=" )





var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xcs-usr-dumb-ims/autosave" )

set_pass0_restoreFile( "ioc-xcs-usr-dumb-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xcs-usr-dumb-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

