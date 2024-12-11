#!/reg/g/pcds/epics/ioc/common/ims/R2.3.9/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:MFX:DG2:IPM:IMS" )
epicsEnvSet( "LOCATION",             "MFX:DG2"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-mfx-dg2-ipm-ims> " )

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

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DG2:MMS:05,PORT=smc-mfx-02:2105,ASYN=MFX:DG2:MMS:05,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DG2:MMS:06,PORT=smc-mfx-02:2106,ASYN=MFX:DG2:MMS:06,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DG2:MMS:07,PORT=smc-mfx-02:2107,ASYN=MFX:DG2:MMS:07,DVER=$(DVER),ERBL=" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DG2:IPM:DIODE,STATE=IN,SET=0,DELTA=0.5,MOVER=MFX:DG2:MMS:06.VAL,RBV=MFX:DG2:MMS:06.RBV,DMOV=MFX:DG2:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DG2:IPM:DIODE,STATE=OUT,SET=-40,DELTA=5.0,MOVER=MFX:DG2:MMS:06.VAL,RBV=MFX:DG2:MMS:06.RBV,DMOV=MFX:DG2:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MFX:DG2:IPM:DIODE,STATE1=IN,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:DG2:MMS:06,ALIAS=MFX:DG2:IPM:DIODE:MOTOR" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:DG2:MMS:05,ALIAS=MFX:DG2:IPM:DIODE:X_MOTOR" )

dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DG2:IPM:TARGET,STATE=TARGET1,SET=22,DELTA=0.5,MOVER=MFX:DG2:MMS:07.VAL,RBV=MFX:DG2:MMS:07.RBV,DMOV=MFX:DG2:MMS:07.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DG2:IPM:TARGET,STATE=TARGET2,SET=36,DELTA=0.5,MOVER=MFX:DG2:MMS:07.VAL,RBV=MFX:DG2:MMS:07.RBV,DMOV=MFX:DG2:MMS:07.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DG2:IPM:TARGET,STATE=TARGET3,SET=49.5,DELTA=0.5,MOVER=MFX:DG2:MMS:07.VAL,RBV=MFX:DG2:MMS:07.RBV,DMOV=MFX:DG2:MMS:07.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DG2:IPM:TARGET,STATE=TARGET4,SET=63,DELTA=0.5,MOVER=MFX:DG2:MMS:07.VAL,RBV=MFX:DG2:MMS:07.RBV,DMOV=MFX:DG2:MMS:07.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DG2:IPM:TARGET,STATE=OUT,SET=85,DELTA=5.0,MOVER=MFX:DG2:MMS:07.VAL,RBV=MFX:DG2:MMS:07.RBV,DMOV=MFX:DG2:MMS:07.DMOV" )

dbLoadRecords( "$(TOP)/db/device_with_5states.db", "DEVICE=MFX:DG2:IPM:TARGET,STATE1=TARGET1,SEVR1=MINOR,STATE2=TARGET2,SEVR2=MINOR,STATE3=TARGET3,SEVR3=MINOR,STATE4=TARGET4,SEVR4=MINOR,STATE5=OUT,SEVR5=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:DG2:MMS:07,ALIAS=MFX:DG2:IPM:TARGET:MOTOR" )














dbLoadRecords( "$(TOP)/db/disp_interlock.db", "ILK=MFX:DG2:MMS:06:ILK,NAME=DG2 IPM Diode/Filter Interlock,MOTOR=MFX:DG2:MMS:06,CALC_DESC=10u XRay not attenuated!,A=MFX:IOC:CTRL:Beam:Attenuated CPP,B=MFX:IOC:CTRL:Configuration CPP,C=,D=,E=,F=,G=,H=,I=,J=,K=,L=,CALC=(B==2)&&!A,CALC_OUT=,CALC_SCAN=Passive,CALC_PINI=YES,VAL_OK=0,VAL_ERR=1,ERR_MSG=DG2 IPM Diode/Filter Interlock Engaged!,FAULT_FLNK=" )
dbLoadRecords( "$(TOP)/db/disp_interlock.db", "ILK=MFX:DG2:MMS:07:ILK,NAME=DG2 IPM Tgt/Filter Interlock,MOTOR=MFX:DG2:MMS:07,CALC_DESC=10u XRay not attenuated!,A=MFX:IOC:CTRL:Beam:Attenuated CPP,B=MFX:IOC:CTRL:Configuration CPP,C=,D=,E=,F=,G=,H=,I=,J=,K=,L=,CALC=(B==2)&&!A,CALC_OUT=,CALC_SCAN=Passive,CALC_PINI=YES,VAL_OK=0,VAL_ERR=1,ERR_MSG=DG2 IPM Tgt/Filter Interlock Engaged!,FAULT_FLNK=" )

var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-mfx-dg2-ipm-ims/autosave" )

set_pass0_restoreFile( "ioc-mfx-dg2-ipm-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-mfx-dg2-ipm-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

