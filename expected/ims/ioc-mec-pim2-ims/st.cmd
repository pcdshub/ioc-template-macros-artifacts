#!/reg/g/pcds/epics/ioc/common/ims/R6.0.0/bin/linux-x86/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:MEC:PIM2:IMS" )
epicsEnvSet( "LOCATION",             "MEC:R60:IOC:38"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-mec-pim2-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Zachary Lentz (zlentz)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )


dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:XT2:MMS:13,PORT=moxa-mec-03:4012,ASYN=MEC:XT2:MMS:13,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:PIM2,STATE=YAG,SET=0,DELTA=0.5,MOVER=MEC:XT2:MMS:13.VAL,RBV=MEC:XT2:MMS:13.RBV,DMOV=MEC:XT2:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:PIM2,STATE=OUT,SET=-52,DELTA=1.0,MOVER=MEC:XT2:MMS:13.VAL,RBV=MEC:XT2:MMS:13.RBV,DMOV=MEC:XT2:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:PIM2,STATE=DIODE,SET=26,DELTA=0.5,MOVER=MEC:XT2:MMS:13.VAL,RBV=MEC:XT2:MMS:13.RBV,DMOV=MEC:XT2:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_3states.db", "DEVICE=MEC:PIM2,STATE1=DIODE,SEVR1=MINOR,STATE2=YAG,SEVR2=MINOR,STATE3=OUT,SEVR3=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:XT2:MMS:13,ALIAS=MEC:PIM2:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:XT2:CLZ:01,PORT=digi-mec-02:2102,ASYN=MEC:XT2:CLZ:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:XT2:CLZ:01,ALIAS=MEC:PIM2:ZOOM_MOTOR" )
dbLoadRecords( "$(TOP)/db/zoom_lens.db", "NAME=MEC:PIM2,IN=MEC:XT2:CLZ:01.RBV CPP,OUT=MEC:XT2:CLZ:01.VAL CPP,NMAX=64" )














var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-mec-pim2-ims/autosave" )

set_pass0_restoreFile( "ioc-mec-pim2-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-mec-pim2-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

