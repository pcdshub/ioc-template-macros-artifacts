#!/reg/g/pcds/epics/ioc/common/ims/R6.3.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XRT:HXS:IMS" )
epicsEnvSet( "LOCATION",             "B960-06-05"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xrt-hxs-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Aalayah Spencer (spencera)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME),P=$(EPICS_NAME):" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )











dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=STEP:XRT1:441:MOTR,PORT=moxa-xrt-spec-01:4001,ASYN=STEP:XRT1:441:MOTR,DVER=$(DVER),ERBL=ABSE:XRT1:441:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=STEP:XRT1:442:MOTR,PORT=moxa-xrt-spec-01:4002,ASYN=STEP:XRT1:442:MOTR,DVER=$(DVER),ERBL=ABSE:XRT1:442:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=STEP:XRT1:443:MOTR,PORT=moxa-xrt-spec-01:4003,ASYN=STEP:XRT1:443:MOTR,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=STEP:XRT1:444:MOTR,PORT=moxa-xrt-spec-01:4004,ASYN=STEP:XRT1:444:MOTR,DVER=$(DVER),ERBL=ABSE:XRT1:444:LE:POSITIONGET" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=STEP:XRT1:445:MOTR,PORT=moxa-xrt-spec-01:4005,ASYN=STEP:XRT1:445:MOTR,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=STEP:XRT1:446:MOTR,PORT=moxa-xrt-spec-01:4006,ASYN=STEP:XRT1:446:MOTR,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=STEP:XRT1:447:MOTR,PORT=moxa-xrt-spec-01:4007,ASYN=STEP:XRT1:447:MOTR,DVER=$(DVER),ERBL=" )


dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:HXS:CRYSTAL,STATE=Si(110)R50,SET=-10.6,DELTA=0.5,MOVER=STEP:XRT1:441:MOTR.VAL,RBV=STEP:XRT1:441:MOTR.RBV,DMOV=STEP:XRT1:441:MOTR.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:HXS:CRYSTAL,STATE=Si(100)R50,SET=-24.85,DELTA=0.5,MOVER=STEP:XRT1:441:MOTR.VAL,RBV=STEP:XRT1:441:MOTR.RBV,DMOV=STEP:XRT1:441:MOTR.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:HXS:CRYSTAL,STATE=Si(100)R200,SET=-40,DELTA=0.5,MOVER=STEP:XRT1:441:MOTR.VAL,RBV=STEP:XRT1:441:MOTR.RBV,DMOV=STEP:XRT1:441:MOTR.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:HXS:CRYSTAL,STATE=Si(111)R200,SET=-53.05,DELTA=0.5,MOVER=STEP:XRT1:441:MOTR.VAL,RBV=STEP:XRT1:441:MOTR.RBV,DMOV=STEP:XRT1:441:MOTR.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:HXS:CRYSTAL,STATE=OUT,SET=2,DELTA=0.5,MOVER=STEP:XRT1:441:MOTR.VAL,RBV=STEP:XRT1:441:MOTR.RBV,DMOV=STEP:XRT1:441:MOTR.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_5states.db", "DEVICE=XRT:HXS:CRYSTAL,STATE1=Si(110)R50,SEVR1=NO_ALARM,STATE2=Si(100)R50,SEVR2=NO_ALARM,STATE3=Si(100)R200,SEVR3=NO_ALARM,STATE4=Si(111)R200,SEVR4=NO_ALARM,STATE5=OUT,SEVR5=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=STEP:XRT1:441:MOTR,ALIAS=XRT:HXS:CRYSTAL:MOTOR" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:HXS:FILTER,STATE=Open,SET=0,DELTA=0.5,MOVER=STEP:XRT1:446:MOTR.VAL,RBV=STEP:XRT1:446:MOTR.RBV,DMOV=STEP:XRT1:446:MOTR.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:HXS:FILTER,STATE=Copper,SET=54,DELTA=0.5,MOVER=STEP:XRT1:446:MOTR.VAL,RBV=STEP:XRT1:446:MOTR.RBV,DMOV=STEP:XRT1:446:MOTR.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:HXS:FILTER,STATE=Nickel,SET=36,DELTA=0.5,MOVER=STEP:XRT1:446:MOTR.VAL,RBV=STEP:XRT1:446:MOTR.RBV,DMOV=STEP:XRT1:446:MOTR.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:HXS:FILTER,STATE=SST,SET=18,DELTA=0.5,MOVER=STEP:XRT1:446:MOTR.VAL,RBV=STEP:XRT1:446:MOTR.RBV,DMOV=STEP:XRT1:446:MOTR.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:HXS:FILTER,STATE=Zn,SET=72,DELTA=0.5,MOVER=STEP:XRT1:446:MOTR.VAL,RBV=STEP:XRT1:446:MOTR.RBV,DMOV=STEP:XRT1:446:MOTR.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XRT:HXS:FILTER,STATE=Ti,SET=90,DELTA=0.5,MOVER=STEP:XRT1:446:MOTR.VAL,RBV=STEP:XRT1:446:MOTR.RBV,DMOV=STEP:XRT1:446:MOTR.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_6states.db", "DEVICE=XRT:HXS:FILTER,STATE1=Open,SEVR1=NO_ALARM,STATE2=Copper,SEVR2=NO_ALARM,STATE3=Nickel,SEVR3=NO_ALARM,STATE4=SST,SEVR4=NO_ALARM,STATE5=Zn,SEVR5=NO_ALARM,STATE6=Ti,SEVR6=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=STEP:XRT1:446:MOTR,ALIAS=XRT:HXS:FILTER:MOTOR" )



var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xrt-hxs-ims/autosave" )

set_pass0_restoreFile( "ioc-xrt-hxs-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xrt-hxs-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

