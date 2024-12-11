#!/reg/g/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XPP:SB2:XFLS:IMS" )
epicsEnvSet( "LOCATION",             "XPP:SB2"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xpp-sb2-xfls-ims> " )

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





dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:13,PORT=moxa-xpp-10:4013,ASYN=XPP:SB2:MMS:13,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:14,PORT=moxa-xpp-10:4014,ASYN=XPP:SB2:MMS:14,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:15,PORT=moxa-xpp-10:4004,ASYN=XPP:SB2:MMS:15,DVER=$(DVER),ERBL=" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:SB2:XFLS,STATE=PACK1,SET=0,DELTA=0.5,MOVER=XPP:SB2:MMS:14.VAL,RBV=XPP:SB2:MMS:14.RBV,DMOV=XPP:SB2:MMS:14.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:SB2:XFLS,STATE=PACK2,SET=16,DELTA=0.5,MOVER=XPP:SB2:MMS:14.VAL,RBV=XPP:SB2:MMS:14.RBV,DMOV=XPP:SB2:MMS:14.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:SB2:XFLS,STATE=PACK3,SET=30,DELTA=0.5,MOVER=XPP:SB2:MMS:14.VAL,RBV=XPP:SB2:MMS:14.RBV,DMOV=XPP:SB2:MMS:14.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:SB2:XFLS,STATE=OUT,SET=56,DELTA=5.0,MOVER=XPP:SB2:MMS:14.VAL,RBV=XPP:SB2:MMS:14.RBV,DMOV=XPP:SB2:MMS:14.DMOV" )

dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=XPP:SB2:XFLS,STATE1=PACK1,SEVR1=MINOR,STATE2=PACK2,SEVR2=MINOR,STATE3=PACK3,SEVR3=MINOR,STATE4=OUT,SEVR4=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:SB2:MMS:13,ALIAS=XPP:SB2:XFLS:X:MOTOR" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:SB2:MMS:14,ALIAS=XPP:SB2:XFLS:Y:MOTOR" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:SB2:MMS:15,ALIAS=XPP:SB2:XFLS:Z:MOTOR" )











var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xpp-sb2-xfls-ims/autosave" )

set_pass0_restoreFile( "ioc-xpp-sb2-xfls-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xpp-sb2-xfls-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

