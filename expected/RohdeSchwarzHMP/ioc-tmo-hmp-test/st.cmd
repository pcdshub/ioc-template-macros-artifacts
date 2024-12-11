#!/reg/g/pcds/epics/ioc/common/RohdeSchwarzHMP/R1.2.2/bin/rhel7-x86_64/rshmp

< envPaths
epicsEnvSet("IOCNAME", "ioc-tmo-hmp-test" )
epicsEnvSet("ENGINEER", "Ricardo Martinez" )
epicsEnvSet("LOCATION", "TMO:IP1:HMP:01" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:TMO:IP1:HMP:01")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/RohdeSchwarzHMP/R1.2.2")
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/tmo/RohdeSchwarzHMP/R1.2.2/build")
epicsEnvSet(streamDebug, 0)
## Add the path to the protocol files
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/rshmp.dbd")
rshmp_registerRecordDeviceDriver(pdbbase)

# Configure each device
drvAsynIPPortConfigure( "TMO:IP1:HMP:01", "pwr-tmo-rohde-01:5025 TCP", 0, 0, 0 )

asynSetTraceMask( "TMO:IP1:HMP:01", 0, 0x1 ) # logging for normal operation

# Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):" )
dbLoadRecords( "db/hmp4040.db", "HMP=TMO:IP1:HMP:01,PORT=TMO:IP1:HMP:01" )

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
