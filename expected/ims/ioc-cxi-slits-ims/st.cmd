#!/reg/g/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:CXI:SLITS:IMS" )
epicsEnvSet( "LOCATION",             "CXI:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-cxi-slits-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Divya Thanasekaran (divya)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME),P=$(EPICS_NAME):" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )







dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DG1:MMS:04,PORT=digi-cxi-01:2101,ASYN=CXI:DG1:MMS:04,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DG1:MMS:05,PORT=digi-cxi-01:2102,ASYN=CXI:DG1:MMS:05,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DG1:MMS:06,PORT=digi-cxi-01:2103,ASYN=CXI:DG1:MMS:06,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DG1:MMS:07,PORT=digi-cxi-01:2104,ASYN=CXI:DG1:MMS:07,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/slit_4jaw.db", "NAME=CXI:DG1:JAWS,M_LFT=CXI:DG1:MMS:04,M_RHT=CXI:DG1:MMS:05,M_TOP=CXI:DG1:MMS:06,M_BOT=CXI:DG1:MMS:07,HALFX=25,HALFY=25" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:KB1:MMS:01,PORT=moxa-cxi-06:4009,ASYN=CXI:KB1:MMS:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:KB1:MMS:02,PORT=moxa-cxi-06:4010,ASYN=CXI:KB1:MMS:02,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:KB1:MMS:03,PORT=moxa-cxi-06:4011,ASYN=CXI:KB1:MMS:03,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:KB1:MMS:04,PORT=moxa-cxi-06:4012,ASYN=CXI:KB1:MMS:04,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/slit_4jaw.db", "NAME=CXI:KB1:JAWS:US,M_LFT=CXI:KB1:MMS:01,M_RHT=CXI:KB1:MMS:02,M_TOP=CXI:KB1:MMS:03,M_BOT=CXI:KB1:MMS:04,HALFX=25,HALFY=25" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:KB1:MMS:13,PORT=moxa-cxi-06:4013,ASYN=CXI:KB1:MMS:13,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:KB1:MMS:14,PORT=moxa-cxi-06:4014,ASYN=CXI:KB1:MMS:14,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:KB1:MMS:15,PORT=moxa-cxi-06:4015,ASYN=CXI:KB1:MMS:15,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:KB1:MMS:16,PORT=moxa-cxi-06:4016,ASYN=CXI:KB1:MMS:16,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/slit_4jaw.db", "NAME=CXI:KB1:JAWS:DS,M_LFT=CXI:KB1:MMS:13,M_RHT=CXI:KB1:MMS:14,M_TOP=CXI:KB1:MMS:15,M_BOT=CXI:KB1:MMS:16,HALFX=25,HALFY=25" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DG2:MMS:01,PORT=moxa-cxi-04:4001,ASYN=CXI:DG2:MMS:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DG2:MMS:02,PORT=moxa-cxi-04:4002,ASYN=CXI:DG2:MMS:02,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DG2:MMS:03,PORT=moxa-cxi-04:4003,ASYN=CXI:DG2:MMS:03,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DG2:MMS:04,PORT=moxa-cxi-04:4004,ASYN=CXI:DG2:MMS:04,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/slit_4jaw.db", "NAME=CXI:DG2:JAWS,M_LFT=CXI:DG2:MMS:01,M_RHT=CXI:DG2:MMS:02,M_TOP=CXI:DG2:MMS:03,M_BOT=CXI:DG2:MMS:04,HALFX=25,HALFY=25" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DSB:MMS:01,PORT=mcs-cxi-01:2101,ASYN=CXI:DSB:MMS:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DSB:MMS:02,PORT=mcs-cxi-01:2102,ASYN=CXI:DSB:MMS:02,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DSB:MMS:03,PORT=mcs-cxi-01:2103,ASYN=CXI:DSB:MMS:03,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DSB:MMS:04,PORT=mcs-cxi-01:2104,ASYN=CXI:DSB:MMS:04,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/slit_4jaw.db", "NAME=CXI:DSB:JAWS,M_LFT=CXI:DSB:MMS:01,M_RHT=CXI:DSB:MMS:02,M_TOP=CXI:DSB:MMS:03,M_BOT=CXI:DSB:MMS:04,HALFX=25,HALFY=25" )









var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-cxi-slits-ims/autosave" )

set_pass0_restoreFile( "ioc-cxi-slits-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-cxi-slits-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

