#!/reg/g/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XPP:MON:CCM:IMS" )
epicsEnvSet( "LOCATION",             "XPP:CCM"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xpp-mon-ccm-ims> " )

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









dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:22,PORT=moxa-xpp-04:4005,ASYN=XPP:MON:MMS:22,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:CCM:X1,STATE=IN,SET=-8.92,DELTA=0.5,MOVER=XPP:MON:MMS:22.VAL,RBV=XPP:MON:MMS:22.RBV,DMOV=XPP:MON:MMS:22.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:CCM:X1,STATE=OUT,SET=0,DELTA=0.5,MOVER=XPP:MON:MMS:22.VAL,RBV=XPP:MON:MMS:22.RBV,DMOV=XPP:MON:MMS:22.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XPP:CCM:X1,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:MON:MMS:22,ALIAS=XPP:CCM:X1:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:23,PORT=moxa-xpp-04:4006,ASYN=XPP:MON:MMS:23,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:CCM:X2,STATE=IN,SET=-8.92,DELTA=0.5,MOVER=XPP:MON:MMS:23.VAL,RBV=XPP:MON:MMS:23.RBV,DMOV=XPP:MON:MMS:23.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:CCM:X2,STATE=OUT,SET=0,DELTA=0.5,MOVER=XPP:MON:MMS:23.VAL,RBV=XPP:MON:MMS:23.RBV,DMOV=XPP:MON:MMS:23.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XPP:CCM:X2,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:MON:MMS:23,ALIAS=XPP:CCM:X2:MOTOR" )

dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XPP:CCM,STATE=IN,COMP1=XPP:CCM:X1,COMP2=XPP:CCM:X2" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XPP:CCM,STATE=OUT,COMP1=XPP:CCM:X1,COMP2=XPP:CCM:X2" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XPP:CCM,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:24,PORT=moxa-xpp-04:4007,ASYN=XPP:MON:MMS:24,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:25,PORT=moxa-xpp-04:4008,ASYN=XPP:MON:MMS:25,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:26,PORT=moxa-xpp-04:4009,ASYN=XPP:MON:MMS:26,DVER=$(DVER),ERBL=" )







var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xpp-mon-ccm-ims/autosave" )

set_pass0_restoreFile( "ioc-xpp-mon-ccm-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xpp-mon-ccm-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

