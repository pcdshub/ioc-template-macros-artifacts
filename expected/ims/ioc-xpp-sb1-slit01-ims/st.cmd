#!/reg/g/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XPP:SB1:SLIT01:IMS" )
epicsEnvSet( "LOCATION",             "XPP:SB1"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xpp-sb1-slit01-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Ali Sabbah (sabbah01)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME),P=$(EPICS_NAME):" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )







dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HX2:SB1:MMS:03,PORT=moxa-xpp-05:4003,ASYN=HX2:SB1:MMS:03,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HX2:SB1:MMS:02,PORT=moxa-xpp-05:4002,ASYN=HX2:SB1:MMS:02,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HX2:SB1:MMS:04,PORT=moxa-xpp-05:4004,ASYN=HX2:SB1:MMS:04,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HX2:SB1:MMS:05,PORT=moxa-xpp-05:4005,ASYN=HX2:SB1:MMS:05,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/slit_4jaw.db", "NAME=HX2:SB1:JAWS,M_LFT=HX2:SB1:MMS:03,M_RHT=HX2:SB1:MMS:02,M_TOP=HX2:SB1:MMS:04,M_BOT=HX2:SB1:MMS:05,HALFX=25,HALFY=25" )









var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xpp-sb1-slit01-ims/autosave" )

set_pass0_restoreFile( "ioc-xpp-sb1-slit01-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xpp-sb1-slit01-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

