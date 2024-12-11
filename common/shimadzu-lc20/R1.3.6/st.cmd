#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/lc20

< envPaths

epicsEnvSet( "ENGINEER",  "$$ENGINEER" )
epicsEnvSet( "LOCATION",  "$$IF(LOCATION,$$LOCATION,$$IOC_PV)" )
epicsEnvSet( "IOC_PV",    "$$IOC_PV" )
epicsEnvSet( "IOCSH_PS1", "$(IOC)> " )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(TOP)/lc20App/srcProtocol" )

cd( "$(TOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/lc20.dbd")
lc20_registerRecordDeviceDriver(pdbbase)

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1

# Load common record instances
dbLoadRecords( "db/iocAdmin.db",		"IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",	"P=$(IOC_PV)" )

# Configure each device
$$LOOP(HPLC)
epicsEnvSet( "DEV$$INDEX", "$$NAME" )
drvAsynIPPortConfigure( "DEV$$INDEX", "$$PORT TCP", 0, 0, 0 )
dbLoadRecords( "db/lc20.db", "DEV=$$NAME,PORT=DEV$$INDEX" )
$$IF(DEBUG,,#)asynSetTraceMask( "DEV$$INDEX", 0, 9 )
$$IF(DEBUG,,#)asynSetTraceIOMask( "DEV$$INDEX", 0, 2 )
$$IF(TFILE,,#)asynSetTraceFile( "DEV$$INDEX",0,"$(IOC_DATA)/$(IOC)/iocInfo/$$TFILE" )

$$ENDLOOP(HPLC)

# Setup autosave
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )

# Just restore the settings
set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "$(IOC).sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOC).req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
