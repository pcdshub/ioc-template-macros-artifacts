#!/cds/group/pcds/epics/ioc/common/mmc/R1.0.5/bin/linux-x86_64/mmc

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:CXI:SC2:PP30:4AXIS:02" )
epicsEnvSet( "LOCATION",             "CXI"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-cxi-sc2-pp30-4axis-02> " )

epicsEnvSet( "ENGINEER",             "Christian Tsoi-A-Sue (ctsoi)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/mmc.dbd" )
mmc_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )

dbLoadRecords( "$(TOP)/db/mmc.db",  "CTRL=IOC:CXI:SC2:PP30:4AXIS:02,PORT=moxa-cxi-09:4015,NAXS=4,ASYN=MMC100" )


dbLoadRecords( "$(TOP)/db/mmca.db", "CTRL=IOC:CXI:SC2:PP30:4AXIS:02,MOTOR=CXI:SC2:MMC:05,AXIS=1" )
dbLoadRecords( "$(TOP)/db/mmca.db", "CTRL=IOC:CXI:SC2:PP30:4AXIS:02,MOTOR=CXI:SC2:MMC:06,AXIS=2" )
dbLoadRecords( "$(TOP)/db/mmca.db", "CTRL=IOC:CXI:SC2:PP30:4AXIS:02,MOTOR=CXI:SC2:MMC:07,AXIS=3" )
dbLoadRecords( "$(TOP)/db/mmca.db", "CTRL=IOC:CXI:SC2:PP30:4AXIS:02,MOTOR=CXI:SC2:MMC:08,AXIS=4" )


var mmcRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-cxi-sc2-pp30-4axis-02/autosave" )

set_pass0_restoreFile( "ioc-cxi-sc2-pp30-4axis-02.sav"                  )


# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-cxi-sc2-pp30-4axis-02.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

