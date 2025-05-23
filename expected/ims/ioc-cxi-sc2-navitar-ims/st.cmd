#!/reg/g/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:CXI:SC2:NAVITAR:IMS" )
epicsEnvSet( "LOCATION",             "CXI:XXX"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-cxi-sc2-navitar-ims> " )

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



dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:SC2:CLZ:03,PORT=moxa-cxi-09:4009,ASYN=CXI:SC2:CLZ:03,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/zoom_lens.db", "NAME=CXI:SC2:NAVITAR,IN=CXI:SC2:CLZ:03.RBV CPP,OUT=CXI:SC2:CLZ:03.VAL CPP,NMAX=64" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=CXI:SC2:CLF:03,PORT=moxa-cxi-09:4010,ASYN=CXI:SC2:CLF:03,DVER=$(DVER),ERBL=" )













var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-cxi-sc2-navitar-ims/autosave" )

set_pass0_restoreFile( "ioc-cxi-sc2-navitar-ims.sav"                  )
set_pass1_restoreFile( "ioc-cxi-sc2-navitar-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-cxi-sc2-navitar-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

