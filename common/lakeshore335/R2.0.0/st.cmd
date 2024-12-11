#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/lakeshore335

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
dbLoadDatabase("dbd/lakeshore335.dbd")
lakeshore335_registerRecordDeviceDriver(pdbbase)

#------------------------------------------------------------------------------
# Asyn support

# Initialize IP Asyn support
$$LOOP(LAKESHORE)
drvAsynSerialPortConfigure("$$PORT","/dev/$$PORT",0,0,0)
asynSetOption("$$PORT",0,"baud","57600")
asynSetOption("$$PORT",0,"bits","7")
asynSetOption("$$PORT",0,"parity","odd")
$$ENDLOOP(LAKESHORE)

$$LOOP(LAKESHORE)
$$IF(ASYNTRACE)
asynSetTraceFile( "$$PORT", 0, "$(IOC_DATA)/$(IOCNAME)/iocInfo/asyn$$PORT.log" )
asynSetTraceMask( "$$PORT", 0, 0x1f) # log everything
asynSetTraceIOMask( "$$PORT", 0, 0x6)
$$ELSE(ASYNTRACE)
$$ENDIF(ASYNTRACE)
$$ENDLOOP(LAKESHORE)

# Load record instances
dbLoadRecords( "db/iocSoft.db",             "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",  "IOC=$(IOC_PV)" )
$$LOOP(LAKESHORE)
dbLoadRecords("db/lakeshore335.db","TCT=$$NAME,PORT=$$PORT,DSCAN=$$IF(DATASCAN,$$DATASCAN,1),CSCAN=$$IF(CONFSCAN,$$CONFSCAN,5)")
$$ENDLOOP(LAKESHORE)

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
