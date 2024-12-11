#!/reg/g/pcds/package/epics/3.14/ioc/common/AgilentE3632A/R1.0.0/bin/linux-x86_64/AgilentE3632A

< envPaths
epicsEnvSet( "ENGINEER",  "Leroy Eshelman (eshelman)" )
epicsEnvSet( "LOCATION",  "XPP Hutch" )
epicsEnvSet( "IOCSH_PS1", "ioc-xpp-pwr01> ")
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(TOP)/AgilentE3632AApp/srcProtocol" )
epicsEnvSet( "EPICS_NAME", "IOC:XPP:PWR01" )
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
drvAsynIPPortConfigure("XPP:EXP:PWR:01","digi-xpp-13:2108 TCP",0,0,0)
dbLoadRecords( "$(TOP)/db/AgilentE3632A.db",	  "P=XPP:EXP:PWR:01" )



# Setup autosave
save_restoreSet_status_prefix( "" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_savefile_path( "$(IOC_DATA)/ioc-xpp-pwr01/autosave" )
set_requestfile_path( "$(TOP)/autosave" )

set_pass0_restoreFile( "ioc-xpp-pwr01" )
set_pass1_restoreFile( "ioc-xpp-pwr01" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "ioc-xpp-pwr01", 5, "IOC=$(EPICS_NAME)" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd


