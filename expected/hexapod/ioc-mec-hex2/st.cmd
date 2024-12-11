#!/reg/g/pcds/epics/ioc/common/hexapod/R2.1.1/bin/rhel7-x86_64/hexapod

< envPaths
epicsEnvSet( "ENGINEER" , "Michael Browne (mcbrowne)" )
epicsEnvSet( "IOCSH_PS1", "ioc-mec-hex2>" )
epicsEnvSet( "IOCPVROOT", "IOC:MEC:HEX2"   )
epicsEnvSet( "LOCATION",  "MEC")
epicsEnvSet( "IOC_TOP",   "/reg/g/pcds/epics/ioc/common/hexapod/R2.1.1"   )
epicsEnvSet( "TOP",       "/reg/g/pcds/epics/ioc/common/hexapod/R2.1.1/children/build"      )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOC_TOP)/protocol" )
cd( "$(IOC_TOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/hexapod.dbd")
hexapod_registerRecordDeviceDriver(pdbbase)

# Configure each motor

drvAsynIPPortConfigure("PI887_0", "hexapod-mec-02:50000 TCP", 0, 0, 0 )

# Load record instances
dbLoadRecords( "db/iocSoft.db",			"IOC=IOC:MEC:HEX2" )
dbLoadRecords( "db/save_restoreStatus.db",	"P=IOC:MEC:HEX2:" )
dbLoadRecords( "db/asynRecord.db",		"Dev=MEC:HEX:02,PORT=PI887_0" )
dbLoadRecords( "db/PIHexapod887.db",		"baseName=MEC:HEX:02,port=PI887_0" )

# Optional: Enable tracing
#asynSetTraceIOMask( "PI887_0",	0,		0 )
#asynSetTraceMask(   "PI887_0",	0,		1 )
#asynSetTraceIOMask( "PI887_0",	0,		1 )
#asynSetTraceMask(   "PI887_0",	0,		9 )

# Send trace output to device specific log files
#asynSetTraceFile(   "PI887_0",	0, "/reg/d/iocData/ioc-mec-hex1/PI887_0.log" )

#/* traceMask definitions*/
##define ASYN_TRACE_ERROR     0x0001
##define ASYN_TRACEIO_DEVICE  0x0002
##define ASYN_TRACEIO_FILTER  0x0004
##define ASYN_TRACEIO_DRIVER  0x0008
##define ASYN_TRACE_FLOW      0x0010

# Setup autosave
save_restoreSet_status_prefix( "IOC:MEC:HEX2:" )
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
