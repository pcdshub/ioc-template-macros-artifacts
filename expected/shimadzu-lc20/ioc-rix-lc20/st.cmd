#!/reg/g/pcds/epics/ioc/common/shimadzu-lc20/R1.3.6/bin/rhel7-x86_64/lc20

< envPaths

epicsEnvSet( "ENGINEER",  "Will Wright (wwright8)" )
epicsEnvSet( "LOCATION",  "RIX" )
epicsEnvSet( "IOC_PV",    "IOC:RIX:LC20:01" )
epicsEnvSet( "IOCSH_PS1", "$(IOC)> " )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(TOP)/lc20App/srcProtocol" )

cd( "$(TOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/lc20.dbd")
lc20_registerRecordDeviceDriver(pdbbase)

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1

# Load common record instances
dbLoadRecords( "db/iocAdmin.db",		"IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",	"P=$(IOC_PV)" )

# Configure each device
epicsEnvSet( "DEV0", "RIX:SDS:LC20:01" )
drvAsynIPPortConfigure( "DEV0", "ser-rix-02:4001 TCP", 0, 0, 0 )
dbLoadRecords( "db/lc20.db", "DEV=RIX:SDS:LC20:01,PORT=DEV0" )
#asynSetTraceMask( "DEV0", 0, 9 )
#asynSetTraceIOMask( "DEV0", 0, 2 )
#asynSetTraceFile( "DEV0",0,"$(IOC_DATA)/$(IOC)/iocInfo/" )

epicsEnvSet( "DEV1", "RIX:SDS:LC20:02" )
drvAsynIPPortConfigure( "DEV1", "ser-rix-02:4002 TCP", 0, 0, 0 )
dbLoadRecords( "db/lc20.db", "DEV=RIX:SDS:LC20:02,PORT=DEV1" )
#asynSetTraceMask( "DEV1", 0, 9 )
#asynSetTraceIOMask( "DEV1", 0, 2 )
#asynSetTraceFile( "DEV1",0,"$(IOC_DATA)/$(IOC)/iocInfo/" )

epicsEnvSet( "DEV2", "RIX:SDS:LC20:03" )
drvAsynIPPortConfigure( "DEV2", "ser-rix-02:4003 TCP", 0, 0, 0 )
dbLoadRecords( "db/lc20.db", "DEV=RIX:SDS:LC20:03,PORT=DEV2" )
#asynSetTraceMask( "DEV2", 0, 9 )
#asynSetTraceIOMask( "DEV2", 0, 2 )
#asynSetTraceFile( "DEV2",0,"$(IOC_DATA)/$(IOC)/iocInfo/" )

epicsEnvSet( "DEV3", "RIX:SDS:LC20:04" )
drvAsynIPPortConfigure( "DEV3", "ser-rix-02:4004 TCP", 0, 0, 0 )
dbLoadRecords( "db/lc20.db", "DEV=RIX:SDS:LC20:04,PORT=DEV3" )
#asynSetTraceMask( "DEV3", 0, 9 )
#asynSetTraceIOMask( "DEV3", 0, 2 )
#asynSetTraceFile( "DEV3",0,"$(IOC_DATA)/$(IOC)/iocInfo/" )


# Setup autosave
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )

# Just restore the settings
set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "$(IOC).sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOC).req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
