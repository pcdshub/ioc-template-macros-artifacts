#!/reg/g/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XPP:TIMETOOL:IMS" )
epicsEnvSet( "LOCATION",             "XPP:TT"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xpp-timetool-ims> " )

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






dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:30,PORT=moxa-xpp-10:4001,ASYN=XPP:SB2:MMS:30,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XPP:SB2:MMS:31,PORT=moxa-xpp-10:4002,ASYN=XPP:SB2:MMS:31,DVER=$(DVER),ERBL=" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:TIMETOOL:Y,STATE=OUT,SET=56,DELTA=5.0,MOVER=XPP:SB2:MMS:31.VAL,RBV=XPP:SB2:MMS:31.RBV,DMOV=XPP:SB2:MMS:31.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:TIMETOOL:Y,STATE=Ti,SET=-49.1,DELTA=0.5,MOVER=XPP:SB2:MMS:31.VAL,RBV=XPP:SB2:MMS:31.RBV,DMOV=XPP:SB2:MMS:31.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:TIMETOOL:Y,STATE=Si3N4_500nm,SET=-33.0,DELTA=0.5,MOVER=XPP:SB2:MMS:31.VAL,RBV=XPP:SB2:MMS:31.RBV,DMOV=XPP:SB2:MMS:31.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:TIMETOOL:Y,STATE=Si3N4_1um,SET=-21.0,DELTA=0.5,MOVER=XPP:SB2:MMS:31.VAL,RBV=XPP:SB2:MMS:31.RBV,DMOV=XPP:SB2:MMS:31.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:TIMETOOL:Y,STATE=Si3N4_3p5um,SET=-11.0,DELTA=0.5,MOVER=XPP:SB2:MMS:31.VAL,RBV=XPP:SB2:MMS:31.RBV,DMOV=XPP:SB2:MMS:31.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:TIMETOOL:Y,STATE=YAG_200um,SET=0.0,DELTA=0.5,MOVER=XPP:SB2:MMS:31.VAL,RBV=XPP:SB2:MMS:31.RBV,DMOV=XPP:SB2:MMS:31.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:TIMETOOL:Y,STATE=YAG_20um,SET=12.0,DELTA=0.5,MOVER=XPP:SB2:MMS:31.VAL,RBV=XPP:SB2:MMS:31.RBV,DMOV=XPP:SB2:MMS:31.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:TIMETOOL:Y,STATE=FrostedYAG,SET=23.0,DELTA=0.5,MOVER=XPP:SB2:MMS:31.VAL,RBV=XPP:SB2:MMS:31.RBV,DMOV=XPP:SB2:MMS:31.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_8states.db", "DEVICE=XPP:TIMETOOL:Y,STATE1=Ti,SEVR1=MINOR,STATE2=Si3N4_500nm,SEVR2=MINOR,STATE3=Si3N4_1um,SEVR3=MINOR,STATE4=Si3N4_3p5um,SEVR4=MINOR,STATE5=YAG_200um,SEVR5=MINOR,STATE6=YAG_20um,SEVR6=MINOR,STATE7=FrostedYAG,SEVR7=MINOR,STATE8=OUT,SEVR8=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:SB2:MMS:31,ALIAS=XPP:TIMETOOL:Y:MOTOR" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:TIMETOOL:X,STATE=OUT,SET=0,DELTA=0.5,MOVER=XPP:SB2:MMS:30.VAL,RBV=XPP:SB2:MMS:30.RBV,DMOV=XPP:SB2:MMS:30.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:TIMETOOL:X,STATE=Ti,SET=0,DELTA=0.05,MOVER=XPP:SB2:MMS:30.VAL,RBV=XPP:SB2:MMS:30.RBV,DMOV=XPP:SB2:MMS:30.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:TIMETOOL:X,STATE=Si3N4_500nm,SET=0,DELTA=0.05,MOVER=XPP:SB2:MMS:30.VAL,RBV=XPP:SB2:MMS:30.RBV,DMOV=XPP:SB2:MMS:30.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:TIMETOOL:X,STATE=Si3N4_1um,SET=0,DELTA=0.05,MOVER=XPP:SB2:MMS:30.VAL,RBV=XPP:SB2:MMS:30.RBV,DMOV=XPP:SB2:MMS:30.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:TIMETOOL:X,STATE=Si3N4_3p5um,SET=0,DELTA=0.05,MOVER=XPP:SB2:MMS:30.VAL,RBV=XPP:SB2:MMS:30.RBV,DMOV=XPP:SB2:MMS:30.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:TIMETOOL:X,STATE=YAG_200um,SET=0,DELTA=0.05,MOVER=XPP:SB2:MMS:30.VAL,RBV=XPP:SB2:MMS:30.RBV,DMOV=XPP:SB2:MMS:30.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:TIMETOOL:X,STATE=YAG_20um,SET=0,DELTA=0.05,MOVER=XPP:SB2:MMS:30.VAL,RBV=XPP:SB2:MMS:30.RBV,DMOV=XPP:SB2:MMS:30.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:TIMETOOL:X,STATE=FrostedYAG,SET=0,DELTA=0.05,MOVER=XPP:SB2:MMS:30.VAL,RBV=XPP:SB2:MMS:30.RBV,DMOV=XPP:SB2:MMS:30.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_8states.db", "DEVICE=XPP:TIMETOOL:X,STATE1=Ti,SEVR1=MINOR,STATE2=Si3N4_500nm,SEVR2=MINOR,STATE3=Si3N4_1um,SEVR3=MINOR,STATE4=Si3N4_3p5um,SEVR4=MINOR,STATE5=YAG_200um,SEVR5=MINOR,STATE6=YAG_20um,SEVR6=MINOR,STATE7=FrostedYAG,SEVR7=MINOR,STATE8=OUT,SEVR8=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:SB2:MMS:30,ALIAS=XPP:TIMETOOL:X:MOTOR" )

dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XPP:TIMETOOL,STATE=OUT,COMP1=XPP:TIMETOOL:Y,COMP2=XPP:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XPP:TIMETOOL,STATE=Ti,COMP1=XPP:TIMETOOL:Y,COMP2=XPP:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XPP:TIMETOOL,STATE=Si3N4_500nm,COMP1=XPP:TIMETOOL:Y,COMP2=XPP:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XPP:TIMETOOL,STATE=Si3N4_1um,COMP1=XPP:TIMETOOL:Y,COMP2=XPP:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XPP:TIMETOOL,STATE=Si3N4_3p5um,COMP1=XPP:TIMETOOL:Y,COMP2=XPP:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XPP:TIMETOOL,STATE=YAG_200um,COMP1=XPP:TIMETOOL:Y,COMP2=XPP:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XPP:TIMETOOL,STATE=YAG_20um,COMP1=XPP:TIMETOOL:Y,COMP2=XPP:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XPP:TIMETOOL,STATE=FrostedYAG,COMP1=XPP:TIMETOOL:Y,COMP2=XPP:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/device_with_8states.db", "DEVICE=XPP:TIMETOOL,STATE1=Ti,SEVR1=MINOR,STATE2=Si3N4_500nm,SEVR2=MINOR,STATE3=Si3N4_1um,SEVR3=MINOR,STATE4=Si3N4_3p5um,SEVR4=MINOR,STATE5=YAG_200um,SEVR5=MINOR,STATE6=YAG_20um,SEVR6=MINOR,STATE7=FrostedYAG,SEVR7=MINOR,STATE8=OUT,SEVR8=NO_ALARM" )











var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xpp-timetool-ims/autosave" )

set_pass0_restoreFile( "ioc-xpp-timetool-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xpp-timetool-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

