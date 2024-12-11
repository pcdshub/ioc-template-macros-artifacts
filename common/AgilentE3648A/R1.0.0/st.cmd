#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/AgilentE3648A

< envPaths
epicsEnvSet( "IOCNAME", "$$IOCNAME" )
epicsEnvSet( "ENGINEER",  "$$ENGINEER" )
epicsEnvSet( "LOCATION",  "$$LOCATION" )
epicsEnvSet( "EPICS_NAME", "$$TRANSLATE(IOCNAME,"a-z_-","A-Z::")" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> ")
epicsEnvSet( "IOC_PV", "$(EPICS_NAME)" )
epicsEnvSet( "IOCTOP", "$$IOCTOP")
epicsEnvSet( "TOP", "$$TOP")
## Add the path to the protocol files
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol" )

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/AgilentE3648A.dbd")
AgilentE3648A_registerRecordDeviceDriver(pdbbase)

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1

# Load record instances
dbLoadRecords( "db/iocSoft.db",             "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",  "IOC=$(IOC_PV)" )
$$LOOP(AGILENT)
dbLoadRecords( "db/AgilentE3648A.db",       "P=$$PV" )
drvAsynIPPortConfigure("$$PV","$$PORT TCP",0,0,0)
$$ENDLOOP(AGILENT)

# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOCNAME)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "$(IOCNAME).sav" )
set_pass1_restoreFile( "$(IOCNAME).sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV)" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
