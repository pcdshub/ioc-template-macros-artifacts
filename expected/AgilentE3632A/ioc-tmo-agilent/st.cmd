#!/reg/g/pcds/epics/ioc/common/AgilentE3632A/R1.0.3/bin/rhel7-x86_64/AgilentE3632A

< envPaths
epicsEnvSet( "ENGINEER",  "Michael Browne (mcbrowne)" )
epicsEnvSet( "LOCATION",  "TMO" )
epicsEnvSet( "IOCSH_PS1", "ioc-tmo-agilent> ")
epicsEnvSet( "IOC_TOP",   "/reg/g/pcds/epics/ioc/common/AgilentE3632A/R1.0.3"   )
epicsEnvSet( "TOP",       "/reg/g/pcds/epics/ioc/tmo/AgilentE3632A/R1.0.0/build"      )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOC_TOP)/AgilentE3632AApp/srcProtocol" )
epicsEnvSet( "EPICS_NAME", "IOC:TMO:AGILENT" )

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
drvAsynIPPortConfigure("TMO:PWR:01","ser-tmo-04:4004 TCP",0,0,0)
dbLoadRecords( "$(IOC_TOP)/db/AgilentE3632A.db",      "P=TMO:PWR:01" )



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


