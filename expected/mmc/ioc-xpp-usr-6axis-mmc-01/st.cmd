#!/reg/g/pcds/package/epics/3.14/ioc/common/mmc/R1.0.5/bin/linux-x86_64/mmc

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XPP:USR:6AXIS:MMC:01" )
epicsEnvSet( "LOCATION",             "XPP"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xpp-usr-6axis-mmc-01> " )

epicsEnvSet( "ENGINEER",             "Vincent Esposito (espov)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/mmc.dbd" )
mmc_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )

dbLoadRecords( "$(TOP)/db/mmc.db",  "CTRL=XPP:USR:6AXIS:MMC:01,PORT=/dev/ftdi-moxa-xpp-08:4012,NAXS=6,ASYN=MMC100" )
dbLoadRecords( "$(TOP)/db/usbsn.db", "CTRL=XPP:USR:6AXIS:MMC:01,SERIAL=moxa-xpp-08:4012,ASYN=MMC100,TIME=1" )


dbLoadRecords( "$(TOP)/db/mmca.db", "CTRL=XPP:USR:6AXIS:MMC:01,MOTOR=XPP:USR:MMC:01,AXIS=1" )
dbLoadRecords( "$(TOP)/db/mmca.db", "CTRL=XPP:USR:6AXIS:MMC:01,MOTOR=XPP:USR:MMC:02,AXIS=2" )
dbLoadRecords( "$(TOP)/db/mmca.db", "CTRL=XPP:USR:6AXIS:MMC:01,MOTOR=XPP:USR:MMC:03,AXIS=3" )
dbLoadRecords( "$(TOP)/db/mmca.db", "CTRL=XPP:USR:6AXIS:MMC:01,MOTOR=XPP:USR:MMC:04,AXIS=4" )
dbLoadRecords( "$(TOP)/db/mmca.db", "CTRL=XPP:USR:6AXIS:MMC:01,MOTOR=XPP:USR:MMC:05,AXIS=5" )
dbLoadRecords( "$(TOP)/db/mmca.db", "CTRL=XPP:USR:6AXIS:MMC:01,MOTOR=XPP:USR:MMC:06,AXIS=6" )


var mmcRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xpp-usr-6axis-mmc-01/autosave" )

set_pass0_restoreFile( "ioc-xpp-usr-6axis-mmc-01.sav"                  )


# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xpp-usr-6axis-mmc-01.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

