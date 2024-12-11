#!/reg/g/pcds/epics/ioc/common/ims/R2.3.9/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:MFX:DG2:PIM:IMS" )
epicsEnvSet( "LOCATION",             "MFX:DG2"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-mfx-dg2-pim-ims> " )

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


dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DG2:MMS:08,PORT=smc-mfx-02:2108,ASYN=MFX:DG2:MMS:08,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DG2:PIM,STATE=YAG,SET=0,DELTA=0.5,MOVER=MFX:DG2:MMS:08.VAL,RBV=MFX:DG2:MMS:08.RBV,DMOV=MFX:DG2:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=MFX:DG2:PIM,STATE=OUT,SET=-52,DELTA=5.0,MOVER=MFX:DG2:MMS:08.VAL,RBV=MFX:DG2:MMS:08.RBV,DMOV=MFX:DG2:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=MFX:DG2:PIM,STATE1=YAG,SEVR1=MINOR,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:DG2:MMS:08,ALIAS=MFX:DG2:PIM:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DG2:CLZ:01,PORT=mcc-mfx-01:2104,ASYN=MFX:DG2:CLZ:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:DG2:CLZ:01,ALIAS=MFX:DG2:PIM:ZOOM_MOTOR" )
dbLoadRecords( "$(TOP)/db/zoom_lens.db", "NAME=MFX:DG2:PIM,IN=MFX:DG2:CLZ:01.RBV CPP,OUT=MFX:DG2:CLZ:01.VAL CPP,NMAX=64" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=MFX:DG2:CLF:01,PORT=mcc-mfx-01:2105,ASYN=MFX:DG2:CLF:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=MFX:DG2:CLF:01,ALIAS=MFX:DG2:PIM:FOCUS_MOTOR" )













dbLoadRecords( "$(TOP)/db/disp_interlock.db", "ILK=MFX:DG2:MMS:08:ILK,NAME=DG2 PIM v FullXRay Interlock,MOTOR=MFX:DG2:MMS:08,CALC_DESC=10u XRay and YAG not out!,A=MFX:IOC:CTRL:Beam:Attenuated,B=,C=MFX:IOC:CTRL:Configuration,D=,E=,F=,G=,H=,I=,J=,K=,L=,CALC=C==2&&!A,CALC_OUT=,CALC_SCAN=Passive,CALC_PINI=YES,VAL_OK=0,VAL_ERR=1,ERR_MSG=DG2 PIM v FullXRay Interlock Engaged!,FAULT_FLNK=" )

var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-mfx-dg2-pim-ims/autosave" )

set_pass0_restoreFile( "ioc-mfx-dg2-pim-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-mfx-dg2-pim-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

