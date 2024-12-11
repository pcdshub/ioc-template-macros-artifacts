#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-86_64)/qepro

epicsEnvSet( "IOCNAME",	  "$$IOCNAME" )
epicsEnvSet( "ENGINEER",  "$$ENGINEER" )
epicsEnvSet( "LOCATION",  "$$LOCATION" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",	  "$$IOC_PV" )
epicsEnvSet( "IOCTOP",	  "$$IOCTOP" )
< envPaths
epicsEnvSet("TOP", "$$TOP")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase( "dbd/qepro.dbd" )
qepro_registerRecordDeviceDriver(pdbbase)


## Set up IOC/hardware links -- LAN connection
##############################################################
$$LOOP(DEVICE)
drvSeaBreezeAPIConfigure("bus$$INDEX", "$$SERNUM", $$NELM)
$$IF(ASYNTRACE)
asynSetTraceMask( "bus$$INDEX", 0, 0x11 )
asynSetTraceIOMask( "bus$$INDEX", 0, 0x0 )
$$ELSE(ASYNTRACE)
asynSetTraceIOMask( "bus$$INDEX", 0, 0x2 ) # logging for normal operation
$$ENDIF(ASYNTRACE)
$$IF(TRACEFILE)
asynSetTraceFile("bus$$INDEX",0,"$(IOC_DATA)/$(IOC)/iocInfo/$$TRACEFILE")
$$ENDIF(TRACEFILE)
$$ENDLOOP(DEVICE)

## Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):")
$$LOOP(DEVICE)
dbLoadRecords("db/seabreezeAPI.template", "P=$$BASE,PORT=bus$$INDEX,NELM=$$NELM")
$$ENDLOOP(DEVICE)

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
