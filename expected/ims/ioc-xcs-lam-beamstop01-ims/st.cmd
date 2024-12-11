#!/reg/g/pcds/epics/ioc/common/ims/R6.0.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XCS:LAM:BEAMSTOP01:IMS" )
epicsEnvSet( "LOCATION",             "XCS:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xcs-lam-beamstop01-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Evan Rodriguez (erod)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )











dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:LAM:MMS:11,PORT=digi-xcs-21:2103,ASYN=XCS:LAM:MMS:11,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:LAM:MMS:12,PORT=digi-xcs-21:2104,ASYN=XCS:LAM:MMS:12,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:LAM:MMS:13,PORT=digi-xcs-21:2105,ASYN=XCS:LAM:MMS:13,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:LAM:MMS:14,PORT=digi-xcs-21:2106,ASYN=XCS:LAM:MMS:14,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:LAM:MMS:15,PORT=digi-xcs-21:2107,ASYN=XCS:LAM:MMS:15,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:LAM:MMS:16,PORT=digi-xcs-21:2108,ASYN=XCS:LAM:MMS:16,DVER=$(DVER),ERBL=" )





var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xcs-lam-beamstop01-ims/autosave" )

set_pass0_restoreFile( "ioc-xcs-lam-beamstop01-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xcs-lam-beamstop01-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

