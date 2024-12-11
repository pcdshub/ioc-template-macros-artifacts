#!/reg/g/pcds/epics/ioc/common/ims/R2.3.9/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:MFX:DIA:PIM:IMS" )
epicsEnvSet( "LOCATION",             "XRT:MFX:DIA"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-mfx-dia-pim-ims> " )

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


dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DIA:MMS:04,PORT=smc-mfx-06:2110,ASYN=MFX:DIA:MMS:04,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DIA:PIM,STATE=YAG,SET=0,DELTA=0.5,MOVER=MFX:DIA:MMS:04.VAL,RBV=MFX:DIA:MMS:04.RBV,DMOV=MFX:DIA:MMS:04.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DIA:PIM,STATE=OUT,SET=-52,DELTA=5.0,MOVER=MFX:DIA:MMS:04.VAL,RBV=MFX:DIA:MMS:04.RBV,DMOV=MFX:DIA:MMS:04.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MFX:DIA:PIM,STATE1=YAG,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:DIA:MMS:04,ALIAS=MFX:DIA:PIM:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DIA:CLZ:01,PORT=digi-mfx-02:2104,ASYN=MFX:DIA:CLZ:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:DIA:CLZ:01,ALIAS=MFX:DIA:PIM:ZOOM_MOTOR" )
dbLoadRecords( "$(TOP)/db/zoom_lens.db", "NAME=MFX:DIA:PIM,IN=MFX:DIA:CLZ:01.RBV CPP,OUT=MFX:DIA:CLZ:01.VAL CPP,NMAX=64" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DIA:CLF:01,PORT=digi-mfx-02:2105,ASYN=MFX:DIA:CLF:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:DIA:CLF:01,ALIAS=MFX:DIA:PIM:FOCUS_MOTOR" )














var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-mfx-dia-pim-ims/autosave" )

set_pass0_restoreFile( "ioc-mfx-dia-pim-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-mfx-dia-pim-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

