#!/reg/g/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:CXI:DG4:IMS" )
epicsEnvSet( "LOCATION",             "CXI:DG2"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-cxi-dg4-ims> " )

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










dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DG4:MMS:04,PORT=digi-cxi-08:2103,ASYN=CXI:DG4:MMS:04,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG4:CSPAD:140K,STATE=IN,SET=-35.0,DELTA=2.0,MOVER=CXI:DG4:MMS:04.VAL,RBV=CXI:DG4:MMS:04.RBV,DMOV=CXI:DG4:MMS:04.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=CXI:DG4:CSPAD:140K,STATE=OUT,SET=0.0,DELTA=2.0,MOVER=CXI:DG4:MMS:04.VAL,RBV=CXI:DG4:MMS:04.RBV,DMOV=CXI:DG4:MMS:04.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=CXI:DG4:CSPAD:140K,STATE1=IN,SEVR1=NO_ALARM,STATE2=OUT,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=CXI:DG4:MMS:04,ALIAS=CXI:DG4:CSPAD:140K:MOTOR" )

dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DG4:MMS:01,PORT=digi-cxi-07:2101,ASYN=CXI:DG4:MMS:01,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DG4:MMS:02,PORT=digi-cxi-08:2101,ASYN=CXI:DG4:MMS:02,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DG4:MMS:03,PORT=digi-cxi-08:2102,ASYN=CXI:DG4:MMS:03,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=CXI:DG4:MMS:05,PORT=digi-cxi-07:2101,ASYN=CXI:DG4:MMS:05,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )





var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-cxi-dg4-ims/autosave" )

set_pass0_restoreFile( "ioc-cxi-dg4-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-cxi-dg4-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

