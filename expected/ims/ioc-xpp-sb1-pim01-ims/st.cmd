#!/reg/g/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XPP:SB1:PIM01:IMS" )
epicsEnvSet( "LOCATION",             "XPP:SB1"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xpp-sb1-pim01-ims> " )

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


dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HX2:SB1:MMS:09,PORT=moxa-xpp-05:4009,ASYN=HX2:SB1:MMS:09,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HX2:SB1:PIM,STATE=YAG,SET=0,DELTA=0.5,MOVER=HX2:SB1:MMS:09.VAL,RBV=HX2:SB1:MMS:09.RBV,DMOV=HX2:SB1:MMS:09.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HX2:SB1:PIM,STATE=OUT,SET=-50,DELTA=1.0,MOVER=HX2:SB1:MMS:09.VAL,RBV=HX2:SB1:MMS:09.RBV,DMOV=HX2:SB1:MMS:09.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HX2:SB1:PIM,STATE=DIODE,SET=26,DELTA=0.5,MOVER=HX2:SB1:MMS:09.VAL,RBV=HX2:SB1:MMS:09.RBV,DMOV=HX2:SB1:MMS:09.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_3states.db", "DEVICE=HX2:SB1:PIM,STATE1=DIODE,SEVR1=MINOR,STATE2=YAG,SEVR2=MINOR,STATE3=OUT,SEVR3=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HX2:SB1:MMS:09,ALIAS=HX2:SB1:PIM:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HX2:SB1:CLZ:01,PORT=moxa-xpp-05:4012,ASYN=HX2:SB1:CLZ:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HX2:SB1:CLZ:01,ALIAS=HX2:SB1:PIM:ZOOM_MOTOR" )
dbLoadRecords( "$(TOP)/db/zoom_lens.db", "NAME=HX2:SB1:PIM,IN=HX2:SB1:CLZ:01.RBV CPP,OUT=HX2:SB1:CLZ:01.VAL CPP,NMAX=64" )














var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xpp-sb1-pim01-ims/autosave" )

set_pass0_restoreFile( "ioc-xpp-sb1-pim01-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xpp-sb1-pim01-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

