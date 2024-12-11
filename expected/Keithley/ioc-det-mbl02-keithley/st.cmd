#!/reg/g/pcds/epics/ioc/common/Keithley/R1.1.0/bin/rhel7-x86_64/Keithley

< envPaths
epicsEnvSet("IOCNAME", "ioc-det-mbl02-keithley" )
epicsEnvSet("ENGINEER", "Daniel Damiani (ddamiani)" )
epicsEnvSet("LOCATION", "DET:MBL2:PSV" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:DET:MBL2:PSV")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/Keithley/R1.1.0")
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/det/Keithley/R1.1.0/build")
epicsEnvSet(streamDebug, 0)
## Add the path to the protocol files
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/Keithley.dbd")
Keithley_registerRecordDeviceDriver(pdbbase)

# Configure each device
drvAsynIPPortConfigure( "DET:MBL2:PSV:01", "digi-det-portable2:2001 TCP", 0, 0, 0 )

asynSetTraceMask( "DET:MBL2:PSV:01", 0, 0x1 ) # logging for normal operation

# Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV)" )
dbLoadRecords( "db/Keithley.db", "CONT=DET:MBL2:PSV:01,PORT=DET:MBL2:PSV:01" )

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
