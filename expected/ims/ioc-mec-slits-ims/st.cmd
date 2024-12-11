#!/reg/g/pcds/epics/ioc/common/ims/R6.0.0/bin/linux-x86/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:MEC:SLITS:IMS" )
epicsEnvSet( "LOCATION",             "MEC:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-mec-slits-ims> " )

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







dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:XT1:MMS:02,PORT=moxa-mec-03:4001,ASYN=MEC:XT1:MMS:02,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:XT1:MMS:03,PORT=moxa-mec-03:4002,ASYN=MEC:XT1:MMS:03,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:XT1:MMS:04,PORT=moxa-mec-03:4003,ASYN=MEC:XT1:MMS:04,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:XT1:MMS:05,PORT=digi-mec-03:2116,ASYN=MEC:XT1:MMS:05,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/slit_4jaw.db", "NAME=MEC:XT1:JAWS:US,M_LFT=MEC:XT1:MMS:02,M_RHT=MEC:XT1:MMS:03,M_TOP=MEC:XT1:MMS:04,M_BOT=MEC:XT1:MMS:05,HALFX=25,HALFY=25" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:XT1:MMS:06,PORT=moxa-mec-03:4005,ASYN=MEC:XT1:MMS:06,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:XT1:MMS:07,PORT=moxa-mec-03:4006,ASYN=MEC:XT1:MMS:07,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:XT1:MMS:08,PORT=moxa-mec-03:4007,ASYN=MEC:XT1:MMS:08,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:XT1:MMS:09,PORT=moxa-mec-03:4008,ASYN=MEC:XT1:MMS:09,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/slit_4jaw.db", "NAME=MEC:XT1:JAWS:DS,M_LFT=MEC:XT1:MMS:06,M_RHT=MEC:XT1:MMS:07,M_TOP=MEC:XT1:MMS:08,M_BOT=MEC:XT1:MMS:09,HALFX=25,HALFY=25" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:XT2:MMS:25,PORT=digi-mec-02:2112,ASYN=MEC:XT2:MMS:25,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:XT2:MMS:24,PORT=digi-mec-02:2111,ASYN=MEC:XT2:MMS:24,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:XT2:MMS:23,PORT=digi-mec-02:2110,ASYN=MEC:XT2:MMS:23,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:XT2:MMS:22,PORT=digi-mec-02:2109,ASYN=MEC:XT2:MMS:22,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/slit_4jaw.db", "NAME=MEC:XT2:JAWS,M_LFT=MEC:XT2:MMS:25,M_RHT=MEC:XT2:MMS:24,M_TOP=MEC:XT2:MMS:23,M_BOT=MEC:XT2:MMS:22,HALFX=25,HALFY=25" )









var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-mec-slits-ims/autosave" )

set_pass0_restoreFile( "ioc-mec-slits-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-mec-slits-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

