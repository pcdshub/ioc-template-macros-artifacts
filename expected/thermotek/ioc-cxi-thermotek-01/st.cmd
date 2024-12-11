#!/reg/g/pcds/epics/ioc/common/thermotek/R1.0.6/bin/rhel7-x86_64/thermotek

epicsEnvSet( "IOCNAME",	  "ioc-cxi-thermotek-01" )
epicsEnvSet( "ENGINEER",  "Rajan Plumley (rajan-01)" )
epicsEnvSet( "LOCATION",  "CXI D51" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",	  "IOC:CXI:TTK" )
epicsEnvSet( "IOCTOP",	  "/reg/g/pcds/epics/ioc/common/thermotek/R1.0.6" )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOCTOP)/app/srcProtocol" )
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/cxi/thermotek/R1.0.0/build")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase( "dbd/thermotek.dbd" )
thermotek_registerRecordDeviceDriver(pdbbase)


## Set up IOC/hardware links -- LAN connection
##############################################################
drvAsynIPPortConfigure( "bus0", "moxa-cxi-05:4001", 0, 0, 0 )
asynSetTraceIOMask( "bus0", 0, 0x1 ) # logging for normal operation

## Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):")
dbLoadRecords( "db/thermotek.db", "P=CXI:JF4M:TTK, DEV=bus0" )

## Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "ioc-cxi-thermotek-01.sav" )
set_pass1_restoreFile( "ioc-cxi-thermotek-01.sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "ioc-cxi-thermotek-01.req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
