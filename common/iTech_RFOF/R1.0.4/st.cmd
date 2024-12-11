#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/rfof

< envPaths

epicsEnvSet( "IOCNAME",	  "$$IOCNAME" )
epicsEnvSet( "ENGINEER",  "$$ENGINEER" )
epicsEnvSet( "LOCATION",  "$$LOCATION" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",	  "$$IOC_PV" )
epicsEnvSet( "IOCTOP",	  "$$IOCTOP" )
epicsEnvSet( "BASE",      "$$BASE"   )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOCTOP)/app/srcProtocol" )
epicsEnvSet("TOP", "$$TOP")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase( "dbd/rfof.dbd" )
rfof_registerRecordDeviceDriver(pdbbase)


## Set up IOC/hardware links -- LAN connection
##############################################################

## RFOF Transmitter
$$LOOP(RFOF_TX)
$$IF(HOST)
drvAsynIPPortConfigure( "tx$$INDEX", "$$HOST:23", 0, 0, 0 )
$$ENDIF(HOST)
dbLoadRecords( "db/rfof_status.db", "BASE=$$BASE, DEV=tx$$INDEX" )
dbLoadRecords( "db/rfof_tx.db", "BASE=$$BASE, DEV=tx$$INDEX" )
epicsEnvSet( "BASE",      "$$BASE"   )

$$IF(ASYNTRACE)
asynSetTraceMask( "tx$$INDEX", 0, 0x09 )
asynSetTraceIOMask( "tx$$INDEX", 0, 0x0 )
asynSetTraceIOTruncateSize("tx0", 0, 512)
$$ELSE(ASYNTRACE)
asynSetTraceIOMask( "tx$$INDEX", 0, 0x2 ) # logging for normal operation
$$ENDIF(ASYNTRACE)
$$IF(TRACEFILE)
asynSetTraceFile("tx$$INDEX",0,"$(IOC_DATA)/$(IOC)/iocInfo/$$TRACEFILE")
$$ENDIF(TRACEFILE)
$$ENDLOOP(RFOF_TX)




## RFOF Raceiver
$$LOOP(RFOF_RX)
$$IF(HOST)
drvAsynIPPortConfigure( "rx$$INDEX", "$$HOST:23", 0, 0, 0 )
$$ENDIF(HOST)
dbLoadRecords( "db/rfof_rx.db", "BASE=$$BASE, DEV=rx$$INDEX" )

$$IF(ASYNTRACE)
asynSetTraceMask( "rx$$INDEX", 0, 0x09 )
asynSetTraceIOMask( "rx$$INDEX", 0, 0x0 )
asynSetTraceIOTruncateSize("tx0", 0, 512)
$$ELSE(ASYNTRACE)
asynSetTraceIOMask( "rx$$INDEX", 0, 0x2 ) # logging for normal operation
$$ENDIF(ASYNTRACE)
$$IF(TRACEFILE)
asynSetTraceFile("rx$$INDEX",0,"$(IOC_DATA)/$(IOC)/iocInfo/$$TRACEFILE")
$$ENDIF(TRACEFILE)
$$ENDLOOP(RFOF_RX)



## Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",  "P=$(IOC_PV):" )

## Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "$$IOCNAME.sav" )

# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req", 5, "" )
create_monitor_set( "$$IOCNAME.req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
