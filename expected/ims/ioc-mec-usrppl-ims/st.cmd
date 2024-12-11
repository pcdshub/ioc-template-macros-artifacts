#!/reg/g/pcds/epics/ioc/common/ims/R6.0.0/bin/linux-x86/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:MEC:USRPPL:IMS" )
epicsEnvSet( "LOCATION",             "MEC:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-mec-usrppl-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Jing Yin (jyin)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )











dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:USR:MMS:17,PORT=digi-mec-09:2101,ASYN=MEC:USR:MMS:17,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:USR:MMS:20,PORT=digi-mec-09:2106,ASYN=MEC:USR:MMS:20,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:USR:MMS:21,PORT=digi-mec-r62-23:2101,ASYN=MEC:USR:MMS:21,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:USR:MMS:22,PORT=digi-mec-r62-23:2102,ASYN=MEC:USR:MMS:22,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:USR:MMS:23,PORT=digi-mec-r62-23:2103,ASYN=MEC:USR:MMS:23,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:USR:MMS:24,PORT=digi-mec-r62-23:2104,ASYN=MEC:USR:MMS:24,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:USR:MMS:25,PORT=digi-mec-09:2107,ASYN=MEC:USR:MMS:25,DVER=$(DVER),ERBL=" )





var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-mec-usrppl-ims/autosave" )

set_pass0_restoreFile( "ioc-mec-usrppl-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-mec-usrppl-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

