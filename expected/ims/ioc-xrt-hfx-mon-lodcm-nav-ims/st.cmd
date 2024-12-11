#!/reg/g/pcds/epics/ioc/common/ims/R6.3.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XRT:HFX:MON:LODCM:NAV:IMS" )
epicsEnvSet( "LOCATION",             "XRT:MON"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xrt-hfx-mon-lodcm-nav-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Ali Sabbah (sabbah01)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME),P=$(EPICS_NAME):" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )



dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:MON:CLZ:01,PORT=moxa-xrt-mon-02:4013,ASYN=HFX:MON:CLZ:01,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/zoom_lens.db", "NAME=HFX:MON:NAVITAR,IN=HFX:MON:CLZ:01.RBV CPP,OUT=HFX:MON:CLZ:01.VAL CPP,NMAX=64" )













var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xrt-hfx-mon-lodcm-nav-ims/autosave" )

set_pass0_restoreFile( "ioc-xrt-hfx-mon-lodcm-nav-ims.sav"                  )
set_pass1_restoreFile( "ioc-xrt-hfx-mon-lodcm-nav-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xrt-hfx-mon-lodcm-nav-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

