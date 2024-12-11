#!/reg/g/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XPP:SB3:PIM01:IMS" )
epicsEnvSet( "LOCATION",             "XPP:SB3"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xpp-sb3-pim01-ims> " )

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


dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB3:MMS:14,PORT=digi-xpp-07:2112,ASYN=XPP:SB3:MMS:14,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:SB3:PIM,STATE=YAG,SET=0,DELTA=0.5,MOVER=XPP:SB3:MMS:14.VAL,RBV=XPP:SB3:MMS:14.RBV,DMOV=XPP:SB3:MMS:14.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:SB3:PIM,STATE=OUT,SET=-50,DELTA=1.0,MOVER=XPP:SB3:MMS:14.VAL,RBV=XPP:SB3:MMS:14.RBV,DMOV=XPP:SB3:MMS:14.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:SB3:PIM,STATE=DIODE,SET=26,DELTA=0.5,MOVER=XPP:SB3:MMS:14.VAL,RBV=XPP:SB3:MMS:14.RBV,DMOV=XPP:SB3:MMS:14.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_3states.db", "DEVICE=XPP:SB3:PIM,STATE1=DIODE,SEVR1=MINOR,STATE2=YAG,SEVR2=MINOR,STATE3=OUT,SEVR3=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:SB3:MMS:14,ALIAS=XPP:SB3:PIM:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB3:CLZ:01,PORT=moxa-xpp-06:4008,ASYN=XPP:SB3:CLZ:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:SB3:CLZ:01,ALIAS=XPP:SB3:PIM:ZOOM_MOTOR" )
dbLoadRecords( "$(TOP)/db/zoom_lens.db", "NAME=XPP:SB3:PIM,IN=XPP:SB3:CLZ:01.RBV CPP,OUT=XPP:SB3:CLZ:01.VAL CPP,NMAX=64" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB3:CLF:01,PORT=moxa-xpp-06:4009,ASYN=XPP:SB3:CLF:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:SB3:CLF:01,ALIAS=XPP:SB3:PIM:FOCUS_MOTOR" )














var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xpp-sb3-pim01-ims/autosave" )

set_pass0_restoreFile( "ioc-xpp-sb3-pim01-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xpp-sb3-pim01-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

