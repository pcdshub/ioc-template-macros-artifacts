#!/reg/g/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:CXI:DG1:IMS" )
epicsEnvSet( "LOCATION",             "CXI:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-cxi-dg1-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Divya Thanasekaran (divya)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME),P=$(EPICS_NAME):" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )


dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DG1:MMS:08,PORT=digi-cxi-01:2105,ASYN=CXI:DG1:MMS:08,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG1:PIM,STATE=YAG,SET=0,DELTA=0.5,MOVER=CXI:DG1:MMS:08.VAL,RBV=CXI:DG1:MMS:08.RBV,DMOV=CXI:DG1:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG1:PIM,STATE=OUT,SET=-52,DELTA=1.0,MOVER=CXI:DG1:MMS:08.VAL,RBV=CXI:DG1:MMS:08.RBV,DMOV=CXI:DG1:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG1:PIM,STATE=DIODE,SET=26,DELTA=0.5,MOVER=CXI:DG1:MMS:08.VAL,RBV=CXI:DG1:MMS:08.RBV,DMOV=CXI:DG1:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_3states.db", "DEVICE=CXI:DG1:PIM,STATE1=DIODE,SEVR1=MINOR,STATE2=YAG,SEVR2=MINOR,STATE3=OUT,SEVR3=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DG1:MMS:08,ALIAS=CXI:DG1:PIM:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DG1:CLZ:01,PORT=digi-cxi-01:2107,ASYN=CXI:DG1:CLZ:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DG1:CLZ:01,ALIAS=CXI:DG1:PIM:ZOOM_MOTOR" )
dbLoadRecords( "$(TOP)/db/zoom_lens.db", "NAME=CXI:DG1:PIM,IN=CXI:DG1:CLZ:01.RBV CPP,OUT=CXI:DG1:CLZ:01.VAL CPP,NMAX=64" )






dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DG1:MMS:01,PORT=digi-cxi-01:2106,ASYN=CXI:DG1:MMS:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG1:RLM:MIRROR,STATE=IN,SET=50,DELTA=0.5,MOVER=CXI:DG1:MMS:01.VAL,RBV=CXI:DG1:MMS:01.RBV,DMOV=CXI:DG1:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG1:RLM:MIRROR,STATE=OUT,SET=0,DELTA=5.0,MOVER=CXI:DG1:MMS:01.VAL,RBV=CXI:DG1:MMS:01.RBV,DMOV=CXI:DG1:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=CXI:DG1:RLM:MIRROR,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DG1:MMS:01,ALIAS=CXI:DG1:RLM:MIRROR:MOTOR" )








var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-cxi-dg1-ims/autosave" )

set_pass0_restoreFile( "ioc-cxi-dg1-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-cxi-dg1-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

