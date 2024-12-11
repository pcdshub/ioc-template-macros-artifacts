#!/reg/g/pcds/epics/ioc/common/NewportXPS8/R2.0.2/bin/rhel7-x86_64/xps8

epicsEnvSet( "EPICS_NAME", "IOC:CXI:XPS:DET2" )
epicsEnvSet( "LOCATION",   "CXI"  )
epicsEnvSet( "IOCSH_PS1",  "ioc-cxi-xps-det2> " )
epicsEnvSet( "ENGINEER",   "Christian Tsoi-A-Sue (ctsoi)"  )


< envPaths

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/xps8.dbd" )
xps8_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocAdmin.db",                "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db",      "IOC=$(EPICS_NAME)" )

dbLoadRecords( "$(TOP)/db/status_update_arbitrary.db", "DEVICE=CXI:DET2:MCN,basePeriod='10 second',multiplier=1" )
dbLoadRecords( "$(TOP)/db/XPS8_arbitrary.db",          "DEVICE=CXI:DET2:MCN,CTRL=mcn-cxi-det2,PORT=5001,POS1=CXI:LAS:MMN:18,POS2=CXI:DSD:MMN:02,POS3=CXI:DSD:MMN:03,POS4=CXI:DSD:MMN:04,POS5=CXI:DSD:MMN:05,POS6=CXI:DSD:MMN:06,POS7=CXI:DSD:MMN:07,POS8=CXI:DSD:MMN:08" )

var xps8Debug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )

set_requestfile_path ( "$(PWD)/../../autosave"  )
set_savefile_path    ( "$(IOC_DATA)/ioc-cxi-xps-det2/autosave" )

set_pass0_restoreFile( "ioc-cxi-xps-det2.sav"                  )

save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-cxi-xps-det2.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

