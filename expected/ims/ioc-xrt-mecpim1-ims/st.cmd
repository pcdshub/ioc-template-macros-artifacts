#!/reg/g/pcds/epics/ioc/common/ims/R6.3.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XRT:MECPIM1:IMS" )
epicsEnvSet( "LOCATION",             "XRT:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xrt-mecpim1-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Peregrine McGehee (peregrin)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME),P=$(EPICS_NAME):" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )


dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:HXM:MMS:16,PORT=moxa-xrt-mec06:4016,ASYN=MEC:HXM:MMS:16,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:HXM:PIM,STATE=YAG,SET=0,DELTA=0.5,MOVER=MEC:HXM:MMS:16.VAL,RBV=MEC:HXM:MMS:16.RBV,DMOV=MEC:HXM:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:HXM:PIM,STATE=OUT,SET=-52,DELTA=5,MOVER=MEC:HXM:MMS:16.VAL,RBV=MEC:HXM:MMS:16.RBV,DMOV=MEC:HXM:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:HXM:PIM,STATE=DIODE,SET=28,DELTA=0.5,MOVER=MEC:HXM:MMS:16.VAL,RBV=MEC:HXM:MMS:16.RBV,DMOV=MEC:HXM:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_3states.db", "DEVICE=MEC:HXM:PIM,STATE1=DIODE,SEVR1=MINOR,STATE2=YAG,SEVR2=MINOR,STATE3=OUT,SEVR3=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:HXM:MMS:16,ALIAS=MEC:HXM:PIM:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:HXM:CLZ:01,PORT=moxa-xrt-dg3-01:4013,ASYN=MEC:HXM:CLZ:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:HXM:CLZ:01,ALIAS=MEC:HXM:PIM:ZOOM_MOTOR" )
dbLoadRecords( "$(TOP)/db/zoom_lens.db", "NAME=MEC:HXM:PIM,IN=MEC:HXM:CLZ:01.RBV CPP,OUT=MEC:HXM:CLZ:01.VAL CPP,NMAX=64" )














var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xrt-mecpim1-ims/autosave" )

set_pass0_restoreFile( "ioc-xrt-mecpim1-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xrt-mecpim1-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

