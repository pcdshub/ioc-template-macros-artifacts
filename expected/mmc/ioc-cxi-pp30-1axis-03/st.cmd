#!/cds/group/pcds/epics/ioc/common/mmc/R1.0.5/bin/linux-x86_64/mmc

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:CXI:PP30:1AXIS:03" )
epicsEnvSet( "LOCATION",             "CXI"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-cxi-pp30-1axis-03> " )

epicsEnvSet( "ENGINEER",             "Christian Tsoi-A-Sue (ctsoi)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/mmc.dbd" )
mmc_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )

dbLoadRecords( "$(TOP)/db/mmc.db",  "CTRL=IOC:CXI:SC2:PP30:1AXIS:03,PORT=moxa-cxi-09:4013,NAXS=1,ASYN=MMC100" )


dbLoadRecords( "$(TOP)/db/mmca.db", "CTRL=IOC:CXI:SC2:PP30:1AXIS:03,MOTOR=CXI:USR:MMC:09,AXIS=1" )


var mmcRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-cxi-pp30-1axis-03/autosave" )

set_pass0_restoreFile( "ioc-cxi-pp30-1axis-03.sav"                  )


# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-cxi-pp30-1axis-03.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

