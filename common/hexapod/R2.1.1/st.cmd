#!$$IOCTOP/bin/$$IF(TARGET_ARCH,$$TARGET_ARCH,linux-x86_64)/hexapod

< envPaths
epicsEnvSet( "ENGINEER" , "$$ENGINEER" )
epicsEnvSet( "IOCSH_PS1", "$$IOCNAME>" )
epicsEnvSet( "IOCPVROOT", "$$IOC_PV"   )
epicsEnvSet( "LOCATION",  "$$IF(LOCATION,$$LOCATION,$$IOC_PV)")
epicsEnvSet( "IOC_TOP",   "$$IOCTOP"   )
epicsEnvSet( "TOP",       "$$TOP"      )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOC_TOP)/protocol" )
cd( "$(IOC_TOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/hexapod.dbd")
hexapod_registerRecordDeviceDriver(pdbbase)

# Configure each motor

$$LOOP(PI887)
drvAsynIPPortConfigure("PI887_$$INDEX", "$$ADDR:50000 TCP", 0, 0, 0 )
$$ENDLOOP(PI887)

# Load record instances
dbLoadRecords( "db/iocSoft.db",			"IOC=$$IOC_PV" )
dbLoadRecords( "db/save_restoreStatus.db",	"P=$$IOC_PV:" )
$$LOOP(PI887)
dbLoadRecords( "db/asynRecord.db",		"Dev=$$BASE,PORT=PI887_$$INDEX" )
dbLoadRecords( "db/PIHexapod887.db",		"baseName=$$BASE,port=PI887_$$INDEX" )

# Optional: Enable tracing
$$IF(DEBUG,,#)asynSetTraceIOMask( "PI887_$$INDEX",	0,		0 )
$$IF(DEBUG,,#)asynSetTraceMask(   "PI887_$$INDEX",	0,		1 )
$$IF(DEBUG,,#)asynSetTraceIOMask( "PI887_$$INDEX",	0,		1 )
$$IF(DEBUG,,#)asynSetTraceMask(   "PI887_$$INDEX",	0,		9 )

# Send trace output to device specific log files
$$IF(LOG,,#)asynSetTraceFile(   "PI887_$$INDEX",	0, "/reg/d/iocData/ioc-mec-hex1/PI887_$$INDEX.log" )
$$ENDLOOP(PI887)

#/* traceMask definitions*/
##define ASYN_TRACE_ERROR     0x0001
##define ASYN_TRACEIO_DEVICE  0x0002
##define ASYN_TRACEIO_FILTER  0x0004
##define ASYN_TRACEIO_DRIVER  0x0008
##define ASYN_TRACE_FLOW      0x0010

# Setup autosave
save_restoreSet_status_prefix( "$$IOC_PV:" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )

# Restore the autosave settings
set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "$(IOC).sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOC).req", 30, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
