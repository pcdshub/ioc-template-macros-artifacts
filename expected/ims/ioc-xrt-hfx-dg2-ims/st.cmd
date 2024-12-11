#!/reg/g/pcds/epics/ioc/common/ims/R6.3.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XRT:HFX:DG2:IMS" )
epicsEnvSet( "LOCATION",             "XRT:DG2"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xrt-hfx-dg2-ims> " )

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
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME),P=$(EPICS_NAME):" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:DG2:MMS:07,PORT=moxa-xrt-dg2-01:4006,ASYN=HFX:DG2:MMS:07,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:DG2:MMS:06,PORT=moxa-xrt-dg2-01:4005,ASYN=HFX:DG2:MMS:06,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:DG2:MMS:08,PORT=moxa-xrt-dg2-01:4007,ASYN=HFX:DG2:MMS:08,DVER=$(DVER),ERBL=" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HFX:DG2:IPM:DIODE,STATE=IN,SET=0,DELTA=0.9,MOVER=HFX:DG2:MMS:06.VAL,RBV=HFX:DG2:MMS:06.RBV,DMOV=HFX:DG2:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HFX:DG2:IPM:DIODE,STATE=OUT,SET=-40,DELTA=0.5,MOVER=HFX:DG2:MMS:06.VAL,RBV=HFX:DG2:MMS:06.RBV,DMOV=HFX:DG2:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=HFX:DG2:IPM:DIODE,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HFX:DG2:MMS:06,ALIAS=HFX:DG2:IPM:DIODE:MOTOR" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HFX:DG2:MMS:07,ALIAS=HFX:DG2:IPM:DIODE:X_MOTOR" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HFX:DG2:IPM:TARGET,STATE=TARGET1,SET=15.85,DELTA=0.5,MOVER=HFX:DG2:MMS:08.VAL,RBV=HFX:DG2:MMS:08.RBV,DMOV=HFX:DG2:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HFX:DG2:IPM:TARGET,STATE=TARGET2,SET=29.4983,DELTA=0.5,MOVER=HFX:DG2:MMS:08.VAL,RBV=HFX:DG2:MMS:08.RBV,DMOV=HFX:DG2:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HFX:DG2:IPM:TARGET,STATE=TARGET3,SET=42.89525,DELTA=0.5,MOVER=HFX:DG2:MMS:08.VAL,RBV=HFX:DG2:MMS:08.RBV,DMOV=HFX:DG2:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HFX:DG2:IPM:TARGET,STATE=TARGET4,SET=56.3994,DELTA=0.5,MOVER=HFX:DG2:MMS:08.VAL,RBV=HFX:DG2:MMS:08.RBV,DMOV=HFX:DG2:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HFX:DG2:IPM:TARGET,STATE=OUT,SET=0,DELTA=1.0,MOVER=HFX:DG2:MMS:08.VAL,RBV=HFX:DG2:MMS:08.RBV,DMOV=HFX:DG2:MMS:08.DMOV" )

dbLoadRecords( "$(TOP)/db/device_with_5states.db", "DEVICE=HFX:DG2:IPM:TARGET,STATE1=TARGET1,SEVR1=MINOR,STATE2=TARGET2,SEVR2=MINOR,STATE3=TARGET3,SEVR3=MINOR,STATE4=TARGET4,SEVR4=MINOR,STATE5=OUT,SEVR5=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HFX:DG2:MMS:08,ALIAS=HFX:DG2:IPM:TARGET:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:DG2:MMS:09,PORT=moxa-xrt-dg2-01:4008,ASYN=HFX:DG2:MMS:09,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HFX:DG2:PIM,STATE=YAG,SET=0,DELTA=0.5,MOVER=HFX:DG2:MMS:09.VAL,RBV=HFX:DG2:MMS:09.RBV,DMOV=HFX:DG2:MMS:09.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HFX:DG2:PIM,STATE=OUT,SET=-52,DELTA=1.0,MOVER=HFX:DG2:MMS:09.VAL,RBV=HFX:DG2:MMS:09.RBV,DMOV=HFX:DG2:MMS:09.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HFX:DG2:PIM,STATE=DIODE,SET=26,DELTA=0.5,MOVER=HFX:DG2:MMS:09.VAL,RBV=HFX:DG2:MMS:09.RBV,DMOV=HFX:DG2:MMS:09.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_3states.db", "DEVICE=HFX:DG2:PIM,STATE1=DIODE,SEVR1=MINOR,STATE2=YAG,SEVR2=MINOR,STATE3=OUT,SEVR3=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HFX:DG2:MMS:09,ALIAS=HFX:DG2:PIM:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:DG2:CLZ:01,PORT=moxa-xrt-dg2-01:4011,ASYN=HFX:DG2:CLZ:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HFX:DG2:CLZ:01,ALIAS=HFX:DG2:PIM:ZOOM_MOTOR" )
dbLoadRecords( "$(TOP)/db/zoom_lens.db", "NAME=HFX:DG2:PIM,IN=HFX:DG2:CLZ:01.RBV CPP,OUT=HFX:DG2:CLZ:01.VAL CPP,NMAX=64" )





dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:DG2:MMS:03,PORT=moxa-xrt-dg2-01:4002,ASYN=HFX:DG2:MMS:03,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:DG2:MMS:02,PORT=moxa-xrt-dg2-01:4001,ASYN=HFX:DG2:MMS:02,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:DG2:MMS:04,PORT=moxa-xrt-dg2-01:4003,ASYN=HFX:DG2:MMS:04,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:DG2:MMS:05,PORT=moxa-xrt-dg2-01:4004,ASYN=HFX:DG2:MMS:05,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/slit_4jaw.db", "NAME=HFX:DG2:JAWS,M_LFT=HFX:DG2:MMS:03,M_RHT=HFX:DG2:MMS:02,M_TOP=HFX:DG2:MMS:04,M_BOT=HFX:DG2:MMS:05,HALFX=25,HALFY=25" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:DG2:MMS:01,PORT=moxa-xrt-dg2-01:4009,ASYN=HFX:DG2:MMS:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HFX:DG2:RLM:MIRROR,STATE=IN,SET=50,DELTA=0.5,MOVER=HFX:DG2:MMS:01.VAL,RBV=HFX:DG2:MMS:01.RBV,DMOV=HFX:DG2:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=HFX:DG2:RLM:MIRROR,STATE=OUT,SET=0,DELTA=5.0,MOVER=HFX:DG2:MMS:01.VAL,RBV=HFX:DG2:MMS:01.RBV,DMOV=HFX:DG2:MMS:01.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=HFX:DG2:RLM:MIRROR,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HFX:DG2:MMS:01,ALIAS=HFX:DG2:RLM:MIRROR:MOTOR" )








var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xrt-hfx-dg2-ims/autosave" )

set_pass0_restoreFile( "ioc-xrt-hfx-dg2-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xrt-hfx-dg2-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

