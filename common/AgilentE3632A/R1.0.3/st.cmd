#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/AgilentE3632A

< envPaths
epicsEnvSet( "ENGINEER",  "$$ENGINEER" )
epicsEnvSet( "LOCATION",  "$$LOCATION" )
epicsEnvSet( "IOCSH_PS1", "$$IOCNAME> ")
epicsEnvSet( "IOC_TOP",   "$$IOCTOP"   )
epicsEnvSet( "TOP",       "$$TOP"      )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOC_TOP)/AgilentE3632AApp/srcProtocol" )
epicsEnvSet( "EPICS_NAME", "$$TRANSLATE(IOCNAME,"a-z_-","A-Z::")" )

cd( "$(IOC_TOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("$(IOC_TOP)/dbd/AgilentE3632A.dbd")
AgilentE3632A_registerRecordDeviceDriver(pdbbase)

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1


# Load record instances
dbLoadRecords( "$(IOC_TOP)/db/iocSoft.db",   	      "IOC=$(EPICS_NAME)")
dbLoadRecords( "$(IOC_TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)")

# Configure each device
$$LOOP(AGILENT)
drvAsynIPPortConfigure("$$PV","$$PORT TCP",0,0,0)
dbLoadRecords( "$(IOC_TOP)/db/AgilentE3632A.db",      "P=$$PV" )

$$ENDLOOP(AGILENT)


# Setup autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )

set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "$(IOC).sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOC).req", 5, "IOC=$(EPICS_NAME)" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd


