#!/reg/g/pcds/epics/ioc/common/ims/R2.3.9/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:MFX:TAB:IMS" )
epicsEnvSet( "LOCATION",             "MFX:RXX:XX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-mfx-tab-ims> " )

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











dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TAB:MMS:01,PORT=smc-mfx-04:2101,ASYN=MFX:TAB:MMS:01,DVER=$(DVER),ERBL=MFX:TAB:MMS:01:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TAB:MMS:02,PORT=smc-mfx-04:2102,ASYN=MFX:TAB:MMS:02,DVER=$(DVER),ERBL=MFX:TAB:MMS:02:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TAB:MMS:03,PORT=smc-mfx-04:2103,ASYN=MFX:TAB:MMS:03,DVER=$(DVER),ERBL=MFX:TAB:MMS:03:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TAB:MMS:04,PORT=smc-mfx-04:2104,ASYN=MFX:TAB:MMS:04,DVER=$(DVER),ERBL=MFX:TAB:MMS:04:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TAB:MMS:05,PORT=smc-mfx-04:2105,ASYN=MFX:TAB:MMS:05,DVER=$(DVER),ERBL=MFX:TAB:MMS:05:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:TAB:MMS:06,PORT=smc-mfx-04:2106,ASYN=MFX:TAB:MMS:06,DVER=$(DVER),ERBL=MFX:TAB:MMS:06:LE:POSITIONGET" )





var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-mfx-tab-ims/autosave" )

set_pass0_restoreFile( "ioc-mfx-tab-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-mfx-tab-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

