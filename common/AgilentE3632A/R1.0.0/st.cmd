#!$$IOCTOP/bin/linux-x86_64/AgilentE3632A

< envPaths
epicsEnvSet( "ENGINEER",  "$$ENGINEER" )
epicsEnvSet( "LOCATION",  "$$LOCATION" )
epicsEnvSet( "IOCSH_PS1", "$$IOCNAME> ")
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(TOP)/AgilentE3632AApp/srcProtocol" )
epicsEnvSet( "EPICS_NAME", "$$TRANSLATE(IOCNAME,"a-z_-","A-Z::")" )
cd( "../.." )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("$(TOP)/dbd/AgilentE3632A.dbd")
AgilentE3632A_registerRecordDeviceDriver(pdbbase)

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1


# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",		  "IOC=$(EPICS_NAME)")
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)")

# Configure each device
$$LOOP(AGILENT)
drvAsynIPPortConfigure("$$PV","$$PORT TCP",0,0,0)
dbLoadRecords( "$(TOP)/db/AgilentE3632A.db",	  "P=$$PV" )

$$ENDLOOP(AGILENT)


# Setup autosave
save_restoreSet_status_prefix( "$$PV" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_savefile_path( "$(IOC_DATA)/$$IOCNAME/autosave" )
set_requestfile_path( "$(TOP)/autosave" )

set_pass0_restoreFile( "$$IOCNAME" )
set_pass1_restoreFile( "$$IOCNAME" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$$IOCNAME", 5, "IOC=$(EPICS_NAME)" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd


