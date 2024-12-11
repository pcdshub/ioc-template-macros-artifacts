#!/reg/g/pcds/epics/ioc/common/SmarPod/R1.1.2/bin/rhel7-x86_64/SmarPod

epicsEnvSet( "IOCNAME",	  "ioc-tmo-smarpod-01" )
epicsEnvSet( "ENGINEER",  "Basil Aljamal (baljamal)" )
epicsEnvSet( "LOCATION",  "TMO DREAM" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",	  "IOC:TMO:SPD:01" )
epicsEnvSet( "IOCTOP",	  "/reg/g/pcds/epics/ioc/common/SmarPod/R1.1.2" )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOCTOP)/app/srcProtocol" )
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/tmo/smarpod/R1.0.0/build")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase( "dbd/SmarPod.dbd" )
SmarPod_registerRecordDeviceDriver(pdbbase)


## Set up IOC/hardware links -- LAN connection
##############################################################
drvAsynIPPortConfigure( "bus0", "tmo-dream-ecm-01:2000", 0, 0, 0 )
asynSetTraceMask( "bus0", 0, 0x9 )
asynSetTraceIOMask( "bus0", 0, 0x2 ) # logging for normal operation

## Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):")
dbLoadRecords( "db/SmarPod.db", "BASE=TMO:SPD:01, DEV=bus0" )

## Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "ioc-tmo-smarpod-01.sav" )

# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req", 5, "" )
create_monitor_set( "ioc-tmo-smarpod-01.req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd