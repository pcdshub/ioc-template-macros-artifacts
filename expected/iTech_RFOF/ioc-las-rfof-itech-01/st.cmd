#!/reg/g/pcds/epics/ioc/common/iTech_RFOF/R1.0.4/bin/rhel7-x86_64/rfof

< envPaths

epicsEnvSet( "IOCNAME",	  "ioc-las-rfof-itech-01" )
epicsEnvSet( "ENGINEER",  "Will Wright (wwright8)" )
epicsEnvSet( "LOCATION",  "Fiber Timing Lab" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",	  "IOC:LAS:RFOF:ITECH:01" )
epicsEnvSet( "IOCTOP",	  "/reg/g/pcds/epics/ioc/common/iTech_RFOF/R1.0.4" )
epicsEnvSet( "BASE",      "LAS:RFOF:ITECH:01"   )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOCTOP)/app/srcProtocol" )
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/las/iTech_RFOF/R1.0.2/build")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase( "dbd/rfof.dbd" )
rfof_registerRecordDeviceDriver(pdbbase)


## Set up IOC/hardware links -- LAN connection
##############################################################

## RFOF Transmitter
drvAsynIPPortConfigure( "tx0", "rfof-las-und-01:23", 0, 0, 0 )
dbLoadRecords( "db/rfof_status.db", "BASE=LAS:RFOF:ITECH:01, DEV=tx0" )
dbLoadRecords( "db/rfof_tx.db", "BASE=LAS:RFOF:ITECH:01, DEV=tx0" )
epicsEnvSet( "BASE",      "LAS:RFOF:ITECH:01"   )

asynSetTraceIOMask( "tx0", 0, 0x2 ) # logging for normal operation




## RFOF Raceiver
drvAsynIPPortConfigure( "rx0", "rfof-las-und-02:23", 0, 0, 0 )
dbLoadRecords( "db/rfof_rx.db", "BASE=LAS:RFOF:ITECH:01, DEV=rx0" )

asynSetTraceIOMask( "rx0", 0, 0x2 ) # logging for normal operation



## Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",  "P=$(IOC_PV):" )

## Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "ioc-las-rfof-itech-01.sav" )

# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req", 5, "" )
create_monitor_set( "ioc-las-rfof-itech-01.req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
