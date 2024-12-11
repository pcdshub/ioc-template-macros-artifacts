#!/reg/g/pcds/epics/ioc/common/ims/R6.0.0/bin/linux-x86/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:MEC:TIMETOOL:IMS" )
epicsEnvSet( "LOCATION",             "MEC:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-mec-timetool-ims> " )

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






dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:FS1:MMS:01,PORT=digi-mec-03:2101,ASYN=MEC:FS1:MMS:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:FS1:MMS:02,PORT=digi-mec-03:2102,ASYN=MEC:FS1:MMS:02,DVER=$(DVER),ERBL=" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:FS1:TIMETOOL:Y,STATE=OUT,SET=0.0,DELTA=5.0,MOVER=MEC:FS1:MMS:02.VAL,RBV=MEC:FS1:MMS:02.RBV,DMOV=MEC:FS1:MMS:02.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:FS1:TIMETOOL:Y,STATE=Ti,SET=-85.0,DELTA=0.5,MOVER=MEC:FS1:MMS:02.VAL,RBV=MEC:FS1:MMS:02.RBV,DMOV=MEC:FS1:MMS:02.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:FS1:TIMETOOL:Y,STATE=SiN2_200nm,SET=-76.0,DELTA=0.5,MOVER=MEC:FS1:MMS:02.VAL,RBV=MEC:FS1:MMS:02.RBV,DMOV=MEC:FS1:MMS:02.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:FS1:TIMETOOL:Y,STATE=SiN2_1um_1,SET=-65.0,DELTA=0.5,MOVER=MEC:FS1:MMS:02.VAL,RBV=MEC:FS1:MMS:02.RBV,DMOV=MEC:FS1:MMS:02.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:FS1:TIMETOOL:Y,STATE=SiN2_1um_2,SET=-54.0,DELTA=0.5,MOVER=MEC:FS1:MMS:02.VAL,RBV=MEC:FS1:MMS:02.RBV,DMOV=MEC:FS1:MMS:02.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:FS1:TIMETOOL:Y,STATE=SiN2_2um_1,SET=-43.0,DELTA=0.5,MOVER=MEC:FS1:MMS:02.VAL,RBV=MEC:FS1:MMS:02.RBV,DMOV=MEC:FS1:MMS:02.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:FS1:TIMETOOL:Y,STATE=SiN2_2um_2,SET=-32.0,DELTA=0.5,MOVER=MEC:FS1:MMS:02.VAL,RBV=MEC:FS1:MMS:02.RBV,DMOV=MEC:FS1:MMS:02.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:FS1:TIMETOOL:Y,STATE=BrokenYAG,SET=-21.0,DELTA=0.5,MOVER=MEC:FS1:MMS:02.VAL,RBV=MEC:FS1:MMS:02.RBV,DMOV=MEC:FS1:MMS:02.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:FS1:TIMETOOL:Y,STATE=FrostedYAG,SET=-11.0,DELTA=0.5,MOVER=MEC:FS1:MMS:02.VAL,RBV=MEC:FS1:MMS:02.RBV,DMOV=MEC:FS1:MMS:02.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_9states.db", "DEVICE=MEC:FS1:TIMETOOL:Y,STATE1=Ti,SEVR1=MINOR,STATE2=SiN2_200nm,SEVR2=MINOR,STATE3=SiN2_1um_1,SEVR3=MINOR,STATE4=SiN2_1um_2,SEVR4=MINOR,STATE5=SiN2_2um_1,SEVR5=MINOR,STATE6=SiN2_2um_2,SEVR6=MINOR,STATE7=BrokenYAG,SEVR7=MINOR,STATE8=FrostedYAG,SEVR8=MINOR,STATE9=OUT,SEVR9=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:FS1:MMS:02,ALIAS=MEC:FS1:TIMETOOL:Y:MOTOR" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:FS1:TIMETOOL:X,STATE=OUT,SET=0.0,DELTA=0.5,MOVER=MEC:FS1:MMS:01.VAL,RBV=MEC:FS1:MMS:01.RBV,DMOV=MEC:FS1:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:FS1:TIMETOOL:X,STATE=Ti,SET=0,DELTA=0.05,MOVER=MEC:FS1:MMS:01.VAL,RBV=MEC:FS1:MMS:01.RBV,DMOV=MEC:FS1:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:FS1:TIMETOOL:X,STATE=SiN2_200nm,SET=0,DELTA=0.05,MOVER=MEC:FS1:MMS:01.VAL,RBV=MEC:FS1:MMS:01.RBV,DMOV=MEC:FS1:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:FS1:TIMETOOL:X,STATE=SiN2_1um_1,SET=0,DELTA=0.05,MOVER=MEC:FS1:MMS:01.VAL,RBV=MEC:FS1:MMS:01.RBV,DMOV=MEC:FS1:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:FS1:TIMETOOL:X,STATE=SiN2_1um_2,SET=0,DELTA=0.05,MOVER=MEC:FS1:MMS:01.VAL,RBV=MEC:FS1:MMS:01.RBV,DMOV=MEC:FS1:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:FS1:TIMETOOL:X,STATE=SiN2_2um_1,SET=0,DELTA=0.05,MOVER=MEC:FS1:MMS:01.VAL,RBV=MEC:FS1:MMS:01.RBV,DMOV=MEC:FS1:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:FS1:TIMETOOL:X,STATE=SiN2_2um_2,SET=0,DELTA=0.05,MOVER=MEC:FS1:MMS:01.VAL,RBV=MEC:FS1:MMS:01.RBV,DMOV=MEC:FS1:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:FS1:TIMETOOL:X,STATE=BrokenYAG,SET=0,DELTA=0.05,MOVER=MEC:FS1:MMS:01.VAL,RBV=MEC:FS1:MMS:01.RBV,DMOV=MEC:FS1:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MEC:FS1:TIMETOOL:X,STATE=FrostedYAG,SET=0,DELTA=0.05,MOVER=MEC:FS1:MMS:01.VAL,RBV=MEC:FS1:MMS:01.RBV,DMOV=MEC:FS1:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_9states.db", "DEVICE=MEC:FS1:TIMETOOL:X,STATE1=Ti,SEVR1=MINOR,STATE2=SiN2_200nm,SEVR2=MINOR,STATE3=SiN2_1um_1,SEVR3=MINOR,STATE4=SiN2_1um_2,SEVR4=MINOR,STATE5=SiN2_2um_1,SEVR5=MINOR,STATE6=SiN2_2um_2,SEVR6=MINOR,STATE7=BrokenYAG,SEVR7=MINOR,STATE8=FrostedYAG,SEVR8=MINOR,STATE9=OUT,SEVR9=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:FS1:MMS:01,ALIAS=MEC:FS1:TIMETOOL:X:MOTOR" )

dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=MEC:FS1:TIMETOOL,STATE=OUT,COMP1=MEC:FS1:TIMETOOL:Y,COMP2=MEC:FS1:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=MEC:FS1:TIMETOOL,STATE=Ti,COMP1=MEC:FS1:TIMETOOL:Y,COMP2=MEC:FS1:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=MEC:FS1:TIMETOOL,STATE=SiN2_200nm,COMP1=MEC:FS1:TIMETOOL:Y,COMP2=MEC:FS1:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=MEC:FS1:TIMETOOL,STATE=SiN2_1um_1,COMP1=MEC:FS1:TIMETOOL:Y,COMP2=MEC:FS1:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=MEC:FS1:TIMETOOL,STATE=SiN2_1um_2,COMP1=MEC:FS1:TIMETOOL:Y,COMP2=MEC:FS1:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=MEC:FS1:TIMETOOL,STATE=SiN2_2um_1,COMP1=MEC:FS1:TIMETOOL:Y,COMP2=MEC:FS1:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=MEC:FS1:TIMETOOL,STATE=SiN2_2um_2,COMP1=MEC:FS1:TIMETOOL:Y,COMP2=MEC:FS1:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=MEC:FS1:TIMETOOL,STATE=BrokenYAG,COMP1=MEC:FS1:TIMETOOL:Y,COMP2=MEC:FS1:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=MEC:FS1:TIMETOOL,STATE=FrostedYAG,COMP1=MEC:FS1:TIMETOOL:Y,COMP2=MEC:FS1:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/device_with_9states.db", "DEVICE=MEC:FS1:TIMETOOL,STATE1=Ti,SEVR1=MINOR,STATE2=SiN2_200nm,SEVR2=MINOR,STATE3=SiN2_1um_1,SEVR3=MINOR,STATE4=SiN2_1um_2,SEVR4=MINOR,STATE5=SiN2_2um_1,SEVR5=MINOR,STATE6=SiN2_2um_2,SEVR6=MINOR,STATE7=BrokenYAG,SEVR7=MINOR,STATE8=FrostedYAG,SEVR8=MINOR,STATE9=OUT,SEVR9=NO_ALARM" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MEC:FS1:MMS:03,PORT=digi-mec-02:2104,ASYN=MEC:FS1:MMS:03,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MEC:FS1:MMS:03,ALIAS=MEC:FS1:TIMETOOL:FOCUS_MOTOR" )










var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-mec-timetool-ims/autosave" )

set_pass0_restoreFile( "ioc-mec-timetool-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-mec-timetool-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

