#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-86_64)/fiber_stretcher

epicsEnvSet( "IOCNAME",	  "$$IOCNAME" )
epicsEnvSet( "ENGINEER",  "$$ENGINEER" )
epicsEnvSet( "LOCATION",  "$$LOCATION" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",	  "$$IOC_PV" )
epicsEnvSet( "IOCTOP",	  "$$IOCTOP" )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOCTOP)/app/srcProtocol" )
< envPaths
epicsEnvSet("TOP", "$$TOP")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase( "dbd/fiber_stretcher.dbd" )
fiber_stretcher_registerRecordDeviceDriver(pdbbase)

$$IF(DEBUG)
var streamDebug 1
$$ENDIF(DEBUG)

## Setup hardware links
############################################################3
$$LOOP(DEVICE)
drvAsynSerialPortConfigure( "bus$$INDEX", "/dev/ftdi-$$SERIAL", 0, 0, 0 )
asynSetOption("bus$$INDEX", 0, "baud", "57600")
$$IF(ASYNTRACE)
asynSetTraceMask( "bus$$INDEX", 0, 0x09 )
asynSetTraceIOMask( "bus$$INDEX", 0, 0x00 ) 
$$ELSE(ASYNTRACE)
asynSetTraceIOMask( "bus$$INDEX", 0, 0x01 ) # logging for normal operation
$$ENDIF(ASYNTRACE)
$$IF(TRACEFILE)
asynSetTraceFile( "bus$$INDEX", 0, "$(IOC_DATA)/$(IOC)/iocInfo/$$TRACEFILE" )
$$ENDIF(TRACEFILE)
$$ENDLOOP(DEVICE)

$$LOOP(PID)
dbLoadRecords("db/pidLoop.db", "BASE=$$BASE_PV,LOOP=PID,VALUE_RBV=$$VALUE_PV,CONTROL_VAL=$$CTL_PV,CONTROL_RBV=$$CTL_RBV")
$$ENDLOOP(PID)

## Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):")
$$LOOP(DEVICE)
dbLoadRecords( "db/fiber_stretcher.db", "BASE=$$BASE, DEV=bus$$INDEX, WAVELENGTH=$$WAVELENGTH, PHASEV=$$PHASEV, DACOUT=$$DACOUT" )
$$ENDLOOP(DEVICE)

## Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "$$IOCNAME.sav" )

set_pass1_restoreFile( "autoSettings.sav" )
set_pass1_restoreFile( "$$IOCNAME.sav" )

# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req", 5, "" )
create_monitor_set( "$$IOCNAME.req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
