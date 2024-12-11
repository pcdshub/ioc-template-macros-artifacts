#!/reg/g/pcds/epics/ioc/common/bk-1697/R1.0.1/bin/rhel7-x86_64/gsd

epicsEnvSet( "IOCNAME",	  "ioc-cxi-bk-01" )
epicsEnvSet( "ENGINEER",  "Divya Thanasekaran (divya)" )
epicsEnvSet( "LOCATION",  "CXI" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",	  "IOC:CXI:BKP:01" )
epicsEnvSet( "IOCTOP",	  "/reg/g/pcds/epics/ioc/common/bk-1697/R1.0.1" )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOCTOP)/app/srcProtocol" )
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/common/bk-1697/R1.0.1/children/build")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase( "dbd/gsd.dbd" )
gsd_registerRecordDeviceDriver(pdbbase)


## Set up IOC/hardware links -- LAN connection
##############################################################
drvAsynIPPortConfigure( "bus0", "moxa-cxi-05:4004", 0, 0, 0 )
asynSetTraceIOMask( "bus0", 0, 0x1 ) # logging for normal operation

## Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):")
dbLoadRecords( "db/bk-1697.db", "BASE=CXI:BKP:01, DEV=bus0" )

## Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "ioc-cxi-bk-01.sav" )

# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req", 5, "" )
create_monitor_set( "ioc-cxi-bk-01.req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd