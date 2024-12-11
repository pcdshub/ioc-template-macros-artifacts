#!/reg/g/pcds/package/epics/3.14/ioc/common/mmc/R1.0.5/bin/linux-x86_64/mmc

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:TMO:CVMI:2AXIS:MMC:01" )
epicsEnvSet( "LOCATION",             "TMO"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-tmo-cvmi-2axis-mmc-01> " )

epicsEnvSet( "ENGINEER",             "Christian Tsoi-A-Sue (ctsoi)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/mmc.dbd" )
mmc_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )

dbLoadRecords( "$(TOP)/db/mmc.db",  "CTRL=TMO:CVMI:2AXIS:MMC:01,PORT=ser-tmo-05:4016,NAXS=2,ASYN=MMC100" )


dbLoadRecords( "$(TOP)/db/mmca.db", "CTRL=TMO:CVMI:2AXIS:MMC:01,MOTOR=TMO:CVMI:MMC:05,AXIS=1" )
dbLoadRecords( "$(TOP)/db/mmca.db", "CTRL=TMO:CVMI:2AXIS:MMC:01,MOTOR=TMO:CVMI:MMC:06,AXIS=2" )


var mmcRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-tmo-cvmi-2axis-mmc-01/autosave" )

set_pass0_restoreFile( "ioc-tmo-cvmi-2axis-mmc-01.sav"                  )


# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-tmo-cvmi-2axis-mmc-01.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

