#!/reg/g/pcds/epics/ioc/common/ims/R6.0.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XCS:SB2:CRL02:IMS" )
epicsEnvSet( "LOCATION",             "XCS:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xcs-sb2-crl02-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Evan Rodriguez (erod)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )





dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB2:MMS:22,PORT=digi-xcs-12:2114,ASYN=XCS:SB2:MMS:22,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB2:MMS:23,PORT=digi-xcs-12:2115,ASYN=XCS:SB2:MMS:23,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB2:MMS:24,PORT=digi-xcs-12:2116,ASYN=XCS:SB2:MMS:24,DVER=$(DVER),ERBL=" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:XFLS,STATE=PACK1,SET=0,DELTA=0.5,MOVER=XCS:SB2:MMS:23.VAL,RBV=XCS:SB2:MMS:23.RBV,DMOV=XCS:SB2:MMS:23.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:XFLS,STATE=PACK2,SET=16,DELTA=0.5,MOVER=XCS:SB2:MMS:23.VAL,RBV=XCS:SB2:MMS:23.RBV,DMOV=XCS:SB2:MMS:23.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:XFLS,STATE=PACK3,SET=30,DELTA=0.5,MOVER=XCS:SB2:MMS:23.VAL,RBV=XCS:SB2:MMS:23.RBV,DMOV=XCS:SB2:MMS:23.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:XFLS,STATE=OUT,SET=56,DELTA=5.0,MOVER=XCS:SB2:MMS:23.VAL,RBV=XCS:SB2:MMS:23.RBV,DMOV=XCS:SB2:MMS:23.DMOV" )

dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=XCS:SB2:XFLS,STATE1=PACK1,SEVR1=MINOR,STATE2=PACK2,SEVR2=MINOR,STATE3=PACK3,SEVR3=MINOR,STATE4=OUT,SEVR4=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB2:MMS:22,ALIAS=XCS:SB2:XFLS:X:MOTOR" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB2:MMS:23,ALIAS=XCS:SB2:XFLS:Y:MOTOR" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB2:MMS:24,ALIAS=XCS:SB2:XFLS:Z:MOTOR" )











var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xcs-sb2-crl02-ims/autosave" )

set_pass0_restoreFile( "ioc-xcs-sb2-crl02-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xcs-sb2-crl02-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

