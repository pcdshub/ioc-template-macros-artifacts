#!/cds/group/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XPP:SB2:DSLITS:IMS" )
epicsEnvSet( "LOCATION",             "XPP:SB2"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xpp-sb2-dslits-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Tyler Pennebaker (pennebak)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME),P=$(EPICS_NAME):" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )







dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:06,PORT=moxa-xpp-10:4006,ASYN=XPP:SB2:MMS:06,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:05,PORT=moxa-xpp-10:4005,ASYN=XPP:SB2:MMS:05,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:07,PORT=moxa-xpp-10:4007,ASYN=XPP:SB2:MMS:07,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:08,PORT=moxa-xpp-10:4008,ASYN=XPP:SB2:MMS:08,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/slit_4jaw.db", "NAME=XPP:SB2L:JAWS,M_LFT=XPP:SB2:MMS:06,M_RHT=XPP:SB2:MMS:05,M_TOP=XPP:SB2:MMS:07,M_BOT=XPP:SB2:MMS:08,HALFX=25,HALFY=25" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:10,PORT=moxa-xpp-10:4010,ASYN=XPP:SB2:MMS:10,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:09,PORT=moxa-xpp-10:4009,ASYN=XPP:SB2:MMS:09,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:11,PORT=moxa-xpp-10:4011,ASYN=XPP:SB2:MMS:11,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:12,PORT=moxa-xpp-10:4012,ASYN=XPP:SB2:MMS:12,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/slit_4jaw.db", "NAME=XPP:SB2H:JAWS,M_LFT=XPP:SB2:MMS:10,M_RHT=XPP:SB2:MMS:09,M_TOP=XPP:SB2:MMS:11,M_BOT=XPP:SB2:MMS:12,HALFX=25,HALFY=25" )









var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xpp-sb2-dslits-ims/autosave" )

set_pass0_restoreFile( "ioc-xpp-sb2-dslits-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xpp-sb2-dslits-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

