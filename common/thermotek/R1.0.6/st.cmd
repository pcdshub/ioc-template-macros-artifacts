#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-86_64)/thermotek

epicsEnvSet( "IOCNAME",	  "$$IOCNAME" )
epicsEnvSet( "ENGINEER",  "$$ENGINEER" )
epicsEnvSet( "LOCATION",  "$$LOCATION" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",	  "$$IOC_PV" )
epicsEnvSet( "IOCTOP",	  "$$IOCTOP" )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOCTOP)/app/srcProtocol" )
< envPaths
epicsEnvSet("TOP", "$$TOP")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase( "dbd/thermotek.dbd" )
thermotek_registerRecordDeviceDriver(pdbbase)


## Set up IOC/hardware links -- LAN connection
##############################################################
$$LOOP(CHILLER)
drvAsynIPPortConfigure( "bus$$INDEX", "$$PORT", 0, 0, 0 )
$$IF(ASYNTRACE)
asynSetTraceMask( "bus$$INDEX", 0, 0x09 )
asynSetTraceIOMask( "bus$$INDEX", 0, 0x0 )
$$ELSE(ASYNTRACE)
asynSetTraceIOMask( "bus$$INDEX", 0, 0x1 ) # logging for normal operation
$$ENDIF(ASYNTRACE)
$$IF(TRACEFILE)
asynSetTraceFile("bus$$INDEX",0,"$(IOC_DATA)/$(IOC)/iocInfo/$$TRACEFILE")
$$ENDIF(TRACEFILE)
$$ENDLOOP(CHILLER)

## Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):")
$$LOOP(CHILLER)
dbLoadRecords( "db/thermotek.db", "P=$$BASE, DEV=bus$$INDEX" )
$$ENDLOOP(CHILLER)

## Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "$$IOCNAME.sav" )
set_pass1_restoreFile( "$$IOCNAME.sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$$IOCNAME.req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
