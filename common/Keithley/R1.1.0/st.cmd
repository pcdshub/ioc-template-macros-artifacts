#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/Keithley

< envPaths
epicsEnvSet("IOCNAME", "$$IOCNAME" )
epicsEnvSet("ENGINEER", "$$ENGINEER" )
epicsEnvSet("LOCATION", "$$LOCATION" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "$$IOC_PV")
epicsEnvSet("IOCTOP", "$$IOCTOP")
epicsEnvSet("TOP", "$$TOP")
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
$$LOOP(CONT)
drvAsynIPPortConfigure( "$$NAME", "$$HOST:$$PORT TCP", 0, 0, 0 )
$$ENDLOOP(CONT)

$$LOOP(CONT)
$$IF(ASYNTRACE)
asynSetTraceFile( "$$NAME", 0, "$(IOC_DATA)/$(IOCNAME)/iocInfo/asyn$$NAME.log" )
asynSetTraceMask( "$$NAME", 0, 0x09 )
asynSetTraceIOMask( "$$NAME", 0, 0x0 )
$$ELSE(ASYNTRACE)
asynSetTraceMask( "$$NAME", 0, 0x1 ) # logging for normal operation
$$ENDIF(ASYNTRACE)
$$ENDLOOP(CONT)

# Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV)" )
$$LOOP(CONT)
dbLoadRecords( "db/Keithley.db", "CONT=$$NAME,PORT=$$NAME" )
$$ENDLOOP(CONT)

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