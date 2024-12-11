#!/reg/g/pcds/epics/ioc/common/ims/R6.0.0/bin/linux-x86/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:MEC:TC1:VT50:IMS" )
epicsEnvSet( "LOCATION",             "MEC:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-mec-tc1-vt50-ims> " )

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











dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:TC1:MMS:22,PORT=digi-mec-09:2105,ASYN=MEC:TC1:MMS:22,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:TC1:MMS:23,PORT=digi-mec-08:2112,ASYN=MEC:TC1:MMS:23,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:TC1:MMS:26,PORT=digi-mec-09:2102,ASYN=MEC:TC1:MMS:26,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:TC1:MMS:29,PORT=digi-mec-07:2108,ASYN=MEC:TC1:MMS:29,DVER=$(DVER),ERBL=" )





var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-mec-tc1-vt50-ims/autosave" )

set_pass0_restoreFile( "ioc-mec-tc1-vt50-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-mec-tc1-vt50-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

