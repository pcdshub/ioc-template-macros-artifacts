#!/reg/g/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:CXI:PI3:IMS" )
epicsEnvSet( "LOCATION",             "CXI:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-cxi-pi3-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Christian Tsoi-A-Sue (ctsoi)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME),P=$(EPICS_NAME):" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )











dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=CXI:PI3:MMS:01,PORT=digi-cxi-03:2109,ASYN=CXI:PI3:MMS:01,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=CXI:PI3:MMS:02,PORT=digi-cxi-03:2110,ASYN=CXI:PI3:MMS:02,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=CXI:PI3:MMS:03,PORT=digi-cxi-03:2111,ASYN=CXI:PI3:MMS:03,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=CXI:PI3:MMS:04,PORT=digi-cxi-03:2112,ASYN=CXI:PI3:MMS:04,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=CXI:PI3:MMS:05,PORT=digi-cxi-03:2113,ASYN=CXI:PI3:MMS:05,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=CXI:PI3:MMS:06,PORT=digi-cxi-03:2114,ASYN=CXI:PI3:MMS:06,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )





var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-cxi-pi3-ims/autosave" )

set_pass0_restoreFile( "ioc-cxi-pi3-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-cxi-pi3-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

