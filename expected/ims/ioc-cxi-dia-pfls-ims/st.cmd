#!/reg/g/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:CXI:DIA:PFLS:IMS" )
epicsEnvSet( "LOCATION",             "CXI:DIA"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-cxi-dia-pfls-ims> " )

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




dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DIA:MMS:14,PORT=digi-cxi-32:2114,ASYN=CXI:DIA:MMS:14,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:PFLS:Y,STATE=12keV,SET=11.800,DELTA=0.5,MOVER=CXI:DIA:MMS:14.VAL,RBV=CXI:DIA:MMS:14.RBV,DMOV=CXI:DIA:MMS:14.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:PFLS:Y,STATE=15keV,SET=30.880,DELTA=0.5,MOVER=CXI:DIA:MMS:14.VAL,RBV=CXI:DIA:MMS:14.RBV,DMOV=CXI:DIA:MMS:14.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:PFLS:Y,STATE=18keV,SET=49.940,DELTA=0.5,MOVER=CXI:DIA:MMS:14.VAL,RBV=CXI:DIA:MMS:14.RBV,DMOV=CXI:DIA:MMS:14.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:PFLS:Y,STATE=OUT,SET=85,DELTA=10,MOVER=CXI:DIA:MMS:14.VAL,RBV=CXI:DIA:MMS:14.RBV,DMOV=CXI:DIA:MMS:14.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=CXI:DIA:PFLS:Y,STATE1=12keV,SEVR1=MINOR,STATE2=15keV,SEVR2=MINOR,STATE3=18keV,SEVR3=MINOR,STATE4=OUT,SEVR4=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DIA:MMS:14,ALIAS=CXI:DIA:PFLS:Y:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DIA:MMS:13,PORT=digi-cxi-32:2113,ASYN=CXI:DIA:MMS:13,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:PFLS:X,STATE=12keV,SET=0,DELTA=0.1,MOVER=CXI:DIA:MMS:13.VAL,RBV=CXI:DIA:MMS:13.RBV,DMOV=CXI:DIA:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:PFLS:X,STATE=15keV,SET=0,DELTA=0.1,MOVER=CXI:DIA:MMS:13.VAL,RBV=CXI:DIA:MMS:13.RBV,DMOV=CXI:DIA:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:PFLS:X,STATE=18keV,SET=0,DELTA=0.1,MOVER=CXI:DIA:MMS:13.VAL,RBV=CXI:DIA:MMS:13.RBV,DMOV=CXI:DIA:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DIA:PFLS:X,STATE=OUT,SET=0,DELTA=1.0,MOVER=CXI:DIA:MMS:13.VAL,RBV=CXI:DIA:MMS:13.RBV,DMOV=CXI:DIA:MMS:13.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=CXI:DIA:PFLS:X,STATE1=12keV,SEVR1=MINOR,STATE2=15keV,SEVR2=MINOR,STATE3=18keV,SEVR3=MINOR,STATE4=OUT,SEVR4=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DIA:MMS:13,ALIAS=CXI:DIA:PFLS:X:MOTOR" )

dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=CXI:DIA:PFLS,STATE=12keV,COMP1=CXI:DIA:PFLS:Y,COMP2=CXI:DIA:PFLS:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=CXI:DIA:PFLS,STATE=15keV,COMP1=CXI:DIA:PFLS:Y,COMP2=CXI:DIA:PFLS:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=CXI:DIA:PFLS,STATE=18keV,COMP1=CXI:DIA:PFLS:Y,COMP2=CXI:DIA:PFLS:X" )
dbLoadRecords( "$(TOP)/db/state_with_2components.db", "DEVICE=CXI:DIA:PFLS,STATE=OUT,COMP1=CXI:DIA:PFLS:Y,COMP2=CXI:DIA:PFLS:X" )
dbLoadRecords( "$(TOP)/db/device_with_4states.db", "DEVICE=CXI:DIA:PFLS,STATE1=12keV,SEVR1=MINOR,STATE2=15keV,SEVR2=MINOR,STATE3=18keV,SEVR3=MINOR,STATE4=OUT,SEVR4=NO_ALARM" )












var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-cxi-dia-pfls-ims/autosave" )

set_pass0_restoreFile( "ioc-cxi-dia-pfls-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-cxi-dia-pfls-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

