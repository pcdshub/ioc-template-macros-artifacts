#!/reg/g/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XPP:SB1:MICOS:IMS" )
epicsEnvSet( "LOCATION",             "XPP:SB1"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xpp-sb1-micos-ims> " )

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








dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HX2:SB1:MMS:01,PORT=moxa-xpp-05:4001,ASYN=HX2:SB1:MMS:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HX2:REFLASER:MIRROR,STATE=IN,SET=50,DELTA=0.5,MOVER=HX2:SB1:MMS:01.VAL,RBV=HX2:SB1:MMS:01.RBV,DMOV=HX2:SB1:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HX2:REFLASER:MIRROR,STATE=OUT,SET=0,DELTA=5.0,MOVER=HX2:SB1:MMS:01.VAL,RBV=HX2:SB1:MMS:01.RBV,DMOV=HX2:SB1:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=HX2:REFLASER:MIRROR,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HX2:SB1:MMS:01,ALIAS=HX2:REFLASER:MIRROR:MOTOR" )








var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xpp-sb1-micos-ims/autosave" )

set_pass0_restoreFile( "ioc-xpp-sb1-micos-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xpp-sb1-micos-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

