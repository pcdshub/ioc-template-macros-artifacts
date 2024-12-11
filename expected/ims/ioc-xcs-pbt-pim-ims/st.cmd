#!/reg/g/pcds/epics/ioc/common/ims/R6.0.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XCS:PBT:PIM:IMS" )
epicsEnvSet( "LOCATION",             "XRT:S80"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xcs-pbt-pim-ims> " )

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


dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:PBT:MMS:01,PORT=digi-xcs-03:2103,ASYN=XCS:PBT:MMS:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:PBT:PIM,STATE=YAG,SET=0,DELTA=0.5,MOVER=XCS:PBT:MMS:01.VAL,RBV=XCS:PBT:MMS:01.RBV,DMOV=XCS:PBT:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:PBT:PIM,STATE=OUT,SET=-52,DELTA=1.0,MOVER=XCS:PBT:MMS:01.VAL,RBV=XCS:PBT:MMS:01.RBV,DMOV=XCS:PBT:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:PBT:PIM,STATE=DIODE,SET=26,DELTA=0.5,MOVER=XCS:PBT:MMS:01.VAL,RBV=XCS:PBT:MMS:01.RBV,DMOV=XCS:PBT:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_3states.db", "DEVICE=XCS:PBT:PIM,STATE1=DIODE,SEVR1=MINOR,STATE2=YAG,SEVR2=MINOR,STATE3=OUT,SEVR3=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:PBT:MMS:01,ALIAS=XCS:PBT:PIM:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:PBT:CLZ:01,PORT=digi-xcs-03:2101,ASYN=XCS:PBT:CLZ:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:PBT:CLZ:01,ALIAS=XCS:PBT:PIM:ZOOM_MOTOR" )
dbLoadRecords( "$(TOP)/db/zoom_lens.db", "NAME=XCS:PBT:PIM,IN=XCS:PBT:CLZ:01.RBV CPP,OUT=XCS:PBT:CLZ:01.VAL CPP,NMAX=64" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:PBT:CLF:01,PORT=digi-xcs-03:2102,ASYN=XCS:PBT:CLF:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:PBT:CLF:01,ALIAS=XCS:PBT:PIM:FOCUS_MOTOR" )














var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xcs-pbt-pim-ims/autosave" )

set_pass0_restoreFile( "ioc-xcs-pbt-pim-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xcs-pbt-pim-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

