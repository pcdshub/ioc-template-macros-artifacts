#!/reg/g/pcds/package/epics/3.14/ioc/common/RohdeSchwarzHMP/R1.1.1/bin/linux-x86_64/rshmp

< envPaths
epicsEnvSet("IOCNAME", "ioc-mfx-det-hmp02" )
epicsEnvSet("ENGINEER", "Daniel Damiani (ddamiani)" )
epicsEnvSet("LOCATION", "MFX:DET:HMP:02" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:MFX:DET:HMP:02")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/RohdeSchwarzHMP/R1.1.1")
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/mfx/RohdeSchwarzHMP/R1.0.0/build")
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
drvAsynSerialPortConfigure( "MFX:DET:HMP:02", "/dev/hameg-100026386829", 0, 0, 0 )
asynSetOption("MFX:DET:HMP:02",0,"baud","115200")
asynSetOption("MFX:DET:HMP:02",0,"bits","8")
asynSetOption("MFX:DET:HMP:02",0,"parity","none")
asynSetOption("MFX:DET:HMP:02",0,"stop","1")
asynSetOption("MFX:DET:HMP:02",0,"crtscts","Y")

asynSetTraceMask( "MFX:DET:HMP:02", 0, 0x1 ) # logging for normal operation

# Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/hmp4030.db", "HMP=MFX:DET:HMP:02,PORT=MFX:DET:HMP:02" )

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
