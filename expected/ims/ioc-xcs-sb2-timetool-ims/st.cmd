#!/reg/g/pcds/epics/ioc/common/ims/R6.0.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XCS:SB2:TIMETOOL:IMS" )
epicsEnvSet( "LOCATION",             "XCS:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xcs-sb2-timetool-ims> " )

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






dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB2:MMS:45,PORT=digi-xcs-13:2113,ASYN=XCS:SB2:MMS:45,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB2:MMS:46,PORT=digi-xcs-13:2114,ASYN=XCS:SB2:MMS:46,DVER=$(DVER),ERBL=" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:TIMETOOL:Y,STATE=OUT,SET=56,DELTA=5.0,MOVER=XCS:SB2:MMS:46.VAL,RBV=XCS:SB2:MMS:46.RBV,DMOV=XCS:SB2:MMS:46.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:TIMETOOL:Y,STATE=Ti,SET=-49.1,DELTA=0.5,MOVER=XCS:SB2:MMS:46.VAL,RBV=XCS:SB2:MMS:46.RBV,DMOV=XCS:SB2:MMS:46.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:TIMETOOL:Y,STATE=Si3N4_500nm,SET=-33.0,DELTA=0.5,MOVER=XCS:SB2:MMS:46.VAL,RBV=XCS:SB2:MMS:46.RBV,DMOV=XCS:SB2:MMS:46.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:TIMETOOL:Y,STATE=Si3N4_1um,SET=-21.0,DELTA=0.5,MOVER=XCS:SB2:MMS:46.VAL,RBV=XCS:SB2:MMS:46.RBV,DMOV=XCS:SB2:MMS:46.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:TIMETOOL:Y,STATE=Si3N4_2um_2,SET=-11.0,DELTA=0.5,MOVER=XCS:SB2:MMS:46.VAL,RBV=XCS:SB2:MMS:46.RBV,DMOV=XCS:SB2:MMS:46.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:TIMETOOL:Y,STATE=Si3N4_2um,SET=0.0,DELTA=0.5,MOVER=XCS:SB2:MMS:46.VAL,RBV=XCS:SB2:MMS:46.RBV,DMOV=XCS:SB2:MMS:46.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:TIMETOOL:Y,STATE=YAG_2um,SET=12.0,DELTA=0.5,MOVER=XCS:SB2:MMS:46.VAL,RBV=XCS:SB2:MMS:46.RBV,DMOV=XCS:SB2:MMS:46.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:TIMETOOL:Y,STATE=FrostedYAG,SET=23.0,DELTA=0.5,MOVER=XCS:SB2:MMS:46.VAL,RBV=XCS:SB2:MMS:46.RBV,DMOV=XCS:SB2:MMS:46.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_8states.db", "DEVICE=XCS:SB2:TIMETOOL:Y,STATE1=Ti,SEVR1=MINOR,STATE2=Si3N4_500nm,SEVR2=MINOR,STATE3=Si3N4_1um,SEVR3=MINOR,STATE4=Si3N4_2um_2,SEVR4=MINOR,STATE5=Si3N4_2um,SEVR5=MINOR,STATE6=YAG_2um,SEVR6=MINOR,STATE7=FrostedYAG,SEVR7=MINOR,STATE8=OUT,SEVR8=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB2:MMS:46,ALIAS=XCS:SB2:TIMETOOL:Y:MOTOR" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:TIMETOOL:X,STATE=OUT,SET=0,DELTA=0.5,MOVER=XCS:SB2:MMS:45.VAL,RBV=XCS:SB2:MMS:45.RBV,DMOV=XCS:SB2:MMS:45.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:TIMETOOL:X,STATE=Ti,SET=0,DELTA=0.05,MOVER=XCS:SB2:MMS:45.VAL,RBV=XCS:SB2:MMS:45.RBV,DMOV=XCS:SB2:MMS:45.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:TIMETOOL:X,STATE=Si3N4_500nm,SET=0,DELTA=0.05,MOVER=XCS:SB2:MMS:45.VAL,RBV=XCS:SB2:MMS:45.RBV,DMOV=XCS:SB2:MMS:45.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:TIMETOOL:X,STATE=Si3N4_1um,SET=0,DELTA=0.05,MOVER=XCS:SB2:MMS:45.VAL,RBV=XCS:SB2:MMS:45.RBV,DMOV=XCS:SB2:MMS:45.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:TIMETOOL:X,STATE=Si3N4_2um_2,SET=0,DELTA=0.05,MOVER=XCS:SB2:MMS:45.VAL,RBV=XCS:SB2:MMS:45.RBV,DMOV=XCS:SB2:MMS:45.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:TIMETOOL:X,STATE=Si3N4_2um,SET=0,DELTA=0.05,MOVER=XCS:SB2:MMS:45.VAL,RBV=XCS:SB2:MMS:45.RBV,DMOV=XCS:SB2:MMS:45.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:TIMETOOL:X,STATE=YAG_2um,SET=0,DELTA=0.05,MOVER=XCS:SB2:MMS:45.VAL,RBV=XCS:SB2:MMS:45.RBV,DMOV=XCS:SB2:MMS:45.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:SB2:TIMETOOL:X,STATE=FrostedYAG,SET=0,DELTA=0.05,MOVER=XCS:SB2:MMS:45.VAL,RBV=XCS:SB2:MMS:45.RBV,DMOV=XCS:SB2:MMS:45.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_8states.db", "DEVICE=XCS:SB2:TIMETOOL:X,STATE1=Ti,SEVR1=MINOR,STATE2=Si3N4_500nm,SEVR2=MINOR,STATE3=Si3N4_1um,SEVR3=MINOR,STATE4=Si3N4_2um_2,SEVR4=MINOR,STATE5=Si3N4_2um,SEVR5=MINOR,STATE6=YAG_2um,SEVR6=MINOR,STATE7=FrostedYAG,SEVR7=MINOR,STATE8=OUT,SEVR8=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB2:MMS:45,ALIAS=XCS:SB2:TIMETOOL:X:MOTOR" )

dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XCS:SB2:TIMETOOL,STATE=OUT,COMP1=XCS:SB2:TIMETOOL:Y,COMP2=XCS:SB2:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XCS:SB2:TIMETOOL,STATE=Ti,COMP1=XCS:SB2:TIMETOOL:Y,COMP2=XCS:SB2:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XCS:SB2:TIMETOOL,STATE=Si3N4_500nm,COMP1=XCS:SB2:TIMETOOL:Y,COMP2=XCS:SB2:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XCS:SB2:TIMETOOL,STATE=Si3N4_1um,COMP1=XCS:SB2:TIMETOOL:Y,COMP2=XCS:SB2:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XCS:SB2:TIMETOOL,STATE=Si3N4_2um_2,COMP1=XCS:SB2:TIMETOOL:Y,COMP2=XCS:SB2:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XCS:SB2:TIMETOOL,STATE=Si3N4_2um,COMP1=XCS:SB2:TIMETOOL:Y,COMP2=XCS:SB2:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XCS:SB2:TIMETOOL,STATE=YAG_2um,COMP1=XCS:SB2:TIMETOOL:Y,COMP2=XCS:SB2:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=XCS:SB2:TIMETOOL,STATE=FrostedYAG,COMP1=XCS:SB2:TIMETOOL:Y,COMP2=XCS:SB2:TIMETOOL:X" )
dbLoadRecords( "$(TOP)/db/device_with_8states.db", "DEVICE=XCS:SB2:TIMETOOL,STATE1=Ti,SEVR1=MINOR,STATE2=Si3N4_500nm,SEVR2=MINOR,STATE3=Si3N4_1um,SEVR3=MINOR,STATE4=Si3N4_2um_2,SEVR4=MINOR,STATE5=Si3N4_2um,SEVR5=MINOR,STATE6=YAG_2um,SEVR6=MINOR,STATE7=FrostedYAG,SEVR7=MINOR,STATE8=OUT,SEVR8=NO_ALARM" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB2:CLZ:02,PORT=digi-xcs-13:2115,ASYN=XCS:SB2:CLZ:02,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB2:CLZ:02,ALIAS=XCS:SB2:TIMETOOL:ZOOM_MOTOR" )
dbLoadRecords( "$(TOP)/db/zoom_lens.db", "NAME=XCS:SB2:TIMETOOL,IN=XCS:SB2:CLZ:02.RBV CPP,OUT=XCS:SB2:CLZ:02.VAL CPP,NMAX=64" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=XCS:SB2:CLF:02,PORT=digi-xcs-13:2116,ASYN=XCS:SB2:CLF:02,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XCS:SB2:CLF:02,ALIAS=XCS:SB2:TIMETOOL:FOCUS_MOTOR" )










var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xcs-sb2-timetool-ims/autosave" )

set_pass0_restoreFile( "ioc-xcs-sb2-timetool-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xcs-sb2-timetool-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

