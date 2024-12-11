#!/reg/g/pcds/package/epics/3.14/ioc/common/ims/R2.1.0/bin/linux-x86/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:AMO:LAMP:STAGE:IMS" )
epicsEnvSet( "LOCATION",             "AMO:LMP:R11:25"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-amo-lamp-stage-ims> " )

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


dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=AMO:LMP:MMS:07,PORT=digi-det-pnccd01:2110,ASYN=AMO:LMP:MMS:07,DVER=$(DVER),ERBL=AMO:LMP:MMS:07:LE:POSITIONGET MS" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=AMO:LMP:MMS:08,PORT=digi-det-pnccd01:2112,ASYN=AMO:LMP:MMS:08,DVER=$(DVER),ERBL=AMO:LMP:MMS:08:LE:POSITIONGET MS" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=AMO:LMP:MMS:09,PORT=digi-det-pnccd01:2104,ASYN=AMO:LMP:MMS:09,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=AMO:LMP:MMS:10,PORT=digi-det-pnccd01:2105,ASYN=AMO:LMP:MMS:10,DVER=$(DVER),ERBL=AMO:LMP:MMS:10:LE:POSITIONGET MS" )





var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-amo-lamp-stage-ims/autosave" )

set_pass0_restoreFile( "ioc-amo-lamp-stage-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-amo-lamp-stage-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

