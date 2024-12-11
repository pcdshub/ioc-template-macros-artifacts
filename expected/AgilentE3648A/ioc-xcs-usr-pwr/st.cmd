#!/reg/g/pcds/package/epics/3.14/ioc/common/AgilentE3648A/R1.0.0/bin/linux-x86_64/AgilentE3648A

< envPaths
epicsEnvSet( "IOCNAME", "ioc-xcs-usr-pwr" )
epicsEnvSet( "ENGINEER",  "Daniel Damiani (ddamiani)" )
epicsEnvSet( "LOCATION",  "XCS Hutch" )
epicsEnvSet( "EPICS_NAME", "IOC:XCS:USR:PWR" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> ")
epicsEnvSet( "IOC_PV", "$(EPICS_NAME)" )
epicsEnvSet( "IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/AgilentE3648A/R1.0.0")
epicsEnvSet( "TOP", "/reg/g/pcds/package/epics/3.14/ioc/xcs/AgilentE3648A/R1.0.1/build")
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
dbLoadRecords( "db/AgilentE3648A.db",       "P=XCS:USR:PWR:01" )
drvAsynIPPortConfigure("XCS:USR:PWR:01","digi-xcs-19:2106 TCP",0,0,0)

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
