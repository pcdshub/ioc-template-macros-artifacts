#!/cds/group/pcds/epics/ioc/common/fiber_stretcher/R1.2.0/bin/rhel7-x86_64/fiber_stretcher

epicsEnvSet( "IOCNAME",	  "ioc-ftl-rfof-ff-01" )
epicsEnvSet( "ENGINEER",  "tjohnson" )
epicsEnvSet( "LOCATION",  "NEH FTL" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",	  "IOC:LAS:FTL:RFOF:FF:01" )
epicsEnvSet( "IOCTOP",	  "/cds/group/pcds/epics/ioc/common/fiber_stretcher/R1.2.0" )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOCTOP)/app/srcProtocol" )
< envPaths
epicsEnvSet("TOP", "/cds/group/pcds/epics/ioc/common/fiber_stretcher/R1.2.0/children/build")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase( "dbd/fiber_stretcher.dbd" )
fiber_stretcher_registerRecordDeviceDriver(pdbbase)


## Setup hardware links
############################################################3
drvAsynSerialPortConfigure( "bus0", "/dev/ftdi-DQ01GN1S", 0, 0, 0 )
asynSetOption("bus0", 0, "baud", "57600")
asynSetTraceIOMask( "bus0", 0, 0x01 ) # logging for normal operation

dbLoadRecords("db/pidLoop.db", "BASE=LAS:FTL:RFOF:FF:01,LOOP=PID,VALUE_RBV=LAS:FTL:RFOF:FF:01:PHASE_DEG,CONTROL_VAL=LAS:FTL:RFOF:FF:01:PID_OUTPUT,CONTROL_RBV=LAS:FTL:RFOF:FF:01:PID_OUTPUT")

## Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):")
dbLoadRecords( "db/fiber_stretcher.db", "BASE=LAS:FTL:RFOF:FF:01, DEV=bus0, WAVELENGTH=CYCLE:WLTX-365:CURRWAVELENGTH, PHASEV=LAS:FTL:BHC:01:AI1:3, DACOUT=NOT:A:REAL:PV" )

## Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "ioc-ftl-rfof-ff-01.sav" )

set_pass1_restoreFile( "autoSettings.sav" )
set_pass1_restoreFile( "ioc-ftl-rfof-ff-01.sav" )

# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req", 5, "" )
create_monitor_set( "ioc-ftl-rfof-ff-01.req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
