#!/reg/g/pcds/epics/ioc/common/ims/R6.3.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XRT:HXX:HXM:PIM01:IMS" )
epicsEnvSet( "LOCATION",             "XRT:RXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xrt-hxx-hxm-pim01-ims> " )

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
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME),P=$(EPICS_NAME):" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )


dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HXX:HXM:MMS:03,PORT=moxa-xrt-mec04:4001,ASYN=HXX:HXM:MMS:03,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HXX:HXM:PIM,STATE=YAG,SET=0,DELTA=0.5,MOVER=HXX:HXM:MMS:03.VAL,RBV=HXX:HXM:MMS:03.RBV,DMOV=HXX:HXM:MMS:03.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HXX:HXM:PIM,STATE=OUT,SET=48,DELTA=30,MOVER=HXX:HXM:MMS:03.VAL,RBV=HXX:HXM:MMS:03.RBV,DMOV=HXX:HXM:MMS:03.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HXX:HXM:PIM,STATE=DIODE,SET=26,DELTA=0.5,MOVER=HXX:HXM:MMS:03.VAL,RBV=HXX:HXM:MMS:03.RBV,DMOV=HXX:HXM:MMS:03.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_3states.db", "DEVICE=HXX:HXM:PIM,STATE1=DIODE,SEVR1=MINOR,STATE2=YAG,SEVR2=MINOR,STATE3=OUT,SEVR3=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HXX:HXM:MMS:03,ALIAS=HXX:HXM:PIM:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HXX:HXM:CLZ:01,PORT=moxa-xrt-mec04:4002,ASYN=HXX:HXM:CLZ:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HXX:HXM:CLZ:01,ALIAS=HXX:HXM:PIM:ZOOM_MOTOR" )
dbLoadRecords( "$(TOP)/db/zoom_lens.db", "NAME=HXX:HXM:PIM,IN=HXX:HXM:CLZ:01.RBV CPP,OUT=HXX:HXM:CLZ:01.VAL CPP,NMAX=64" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HXX:HXM:CLF:01,PORT=moxa-xrt-mec04:4003,ASYN=HXX:HXM:CLF:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HXX:HXM:CLF:01,ALIAS=HXX:HXM:PIM:FOCUS_MOTOR" )














var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xrt-hxx-hxm-pim01-ims/autosave" )

set_pass0_restoreFile( "ioc-xrt-hxx-hxm-pim01-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xrt-hxx-hxm-pim01-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

