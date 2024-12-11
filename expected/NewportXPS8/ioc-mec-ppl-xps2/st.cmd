#!/reg/g/pcds/package/epics/3.14/ioc/common/NewportXPS8/R2.0.1/bin/linux-x86_64/xps8

epicsEnvSet( "EPICS_NAME", "IOC:MEC:PPL:XPS2" )
epicsEnvSet( "LOCATION",   "SLAC:LCLS"  )
epicsEnvSet( "IOCSH_PS1",  "ioc-mec-ppl-xps2> " )
epicsEnvSet( "ENGINEER",   "Zhou Xing (zxing)"  )


< envPaths

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/xps8.dbd" )
xps8_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocAdmin.db",                "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db",      "IOC=$(EPICS_NAME)" )

dbLoadRecords( "$(TOP)/db/status_update.db",           "DEVICE=MEC:PPL:MMN,C1=09,C8=16,basePeriod='10 second',multiplier=1" )
dbLoadRecords( "$(TOP)/db/XPS8.db",                    "DEVICE=MEC:PPL:MMN,CTRL=mcn-mec-tch2,PORT=5001,C1=09,C2=10,C3=11,C4=12,C5=13,C6=14,C7=15,C8=16" )

var xps8Debug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )

set_requestfile_path ( "$(PWD)/../../autosave"  )
set_savefile_path    ( "$(IOC_DATA)/ioc-mec-ppl-xps2/autosave" )

set_pass0_restoreFile( "ioc-mec-ppl-xps2.sav"                  )

save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-mec-ppl-xps2.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

