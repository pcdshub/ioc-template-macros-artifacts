#!/reg/g/pcds/epics/ioc/common/ims/R2.3.9/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:MFX:SLITS:IMS" )
epicsEnvSet( "LOCATION",             "MFX:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-mfx-slits-ims> " )

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







dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DG1:MMS:05,PORT=smc-mfx-01:2104,ASYN=MFX:DG1:MMS:05,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DG1:MMS:04,PORT=smc-mfx-01:2103,ASYN=MFX:DG1:MMS:04,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DG1:MMS:03,PORT=smc-mfx-01:2102,ASYN=MFX:DG1:MMS:03,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DG1:MMS:02,PORT=smc-mfx-01:2101,ASYN=MFX:DG1:MMS:02,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/slit_4jaw.db", "NAME=MFX:DG1:JAWS,M_LFT=MFX:DG1:MMS:05,M_RHT=MFX:DG1:MMS:04,M_TOP=MFX:DG1:MMS:03,M_BOT=MFX:DG1:MMS:02,HALFX=25,HALFY=25" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DG2:MMS:04,PORT=smc-mfx-02:2104,ASYN=MFX:DG2:MMS:04,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DG2:MMS:03,PORT=smc-mfx-02:2103,ASYN=MFX:DG2:MMS:03,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DG2:MMS:02,PORT=smc-mfx-02:2102,ASYN=MFX:DG2:MMS:02,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DG2:MMS:01,PORT=smc-mfx-02:2101,ASYN=MFX:DG2:MMS:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/slit_4jaw.db", "NAME=MFX:DG2:JAWS:US,M_LFT=MFX:DG2:MMS:04,M_RHT=MFX:DG2:MMS:03,M_TOP=MFX:DG2:MMS:02,M_BOT=MFX:DG2:MMS:01,HALFX=25,HALFY=25" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DG2:MMS:15,PORT=smc-mfx-02:2112,ASYN=MFX:DG2:MMS:15,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DG2:MMS:14,PORT=smc-mfx-02:2111,ASYN=MFX:DG2:MMS:14,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DG2:MMS:13,PORT=smc-mfx-02:2110,ASYN=MFX:DG2:MMS:13,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DG2:MMS:12,PORT=smc-mfx-02:2109,ASYN=MFX:DG2:MMS:12,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/slit_4jaw.db", "NAME=MFX:DG2:JAWS:MS,M_LFT=MFX:DG2:MMS:15,M_RHT=MFX:DG2:MMS:14,M_TOP=MFX:DG2:MMS:13,M_BOT=MFX:DG2:MMS:12,HALFX=25,HALFY=25" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DG2:MMS:19,PORT=smc-mfx-02:2116,ASYN=MFX:DG2:MMS:19,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DG2:MMS:18,PORT=smc-mfx-02:2115,ASYN=MFX:DG2:MMS:18,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DG2:MMS:17,PORT=smc-mfx-02:2114,ASYN=MFX:DG2:MMS:17,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DG2:MMS:16,PORT=smc-mfx-02:2113,ASYN=MFX:DG2:MMS:16,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/slit_4jaw.db", "NAME=MFX:DG2:JAWS:DS,M_LFT=MFX:DG2:MMS:19,M_RHT=MFX:DG2:MMS:18,M_TOP=MFX:DG2:MMS:17,M_BOT=MFX:DG2:MMS:16,HALFX=25,HALFY=25" )









var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-mfx-slits-ims/autosave" )

set_pass0_restoreFile( "ioc-mfx-slits-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-mfx-slits-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

