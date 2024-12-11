#!$$IOCTOP/bin/$$ARCH/Keithley6514

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

< envPaths
epicsEnvSet( "IOCNAME",      "$$IOCNAME" )
epicsEnvSet( "ENGINEER",     "$$ENGINEER" )
epicsEnvSet( "LOCATION",     "$$LOCATION" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "$$IOC_PV" )
epicsEnvSet( "IOCTOP",       "$$IOCTOP" )
epicsEnvSet( "BUILD_TOP",    "$$TOP" )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOCTOP)/db" )

cd( "$(IOCTOP)" )

# Set Max array size
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "$$IF(MAX_ARRAY,$$MAX_ARRAY,20000000)" )

# Register all support components
dbLoadDatabase("dbd/Keithley6514.dbd")
Keithley6514_registerRecordDeviceDriver(pdbbase)

# Load soft ioc related record instances
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/iocRelease.db",			"IOC=$(IOC_PV)" )

# Configure the Electrometer
$$LOOP(ETM)

epicsEnvSet( "DEV_INFO", "DEV=$$NAME,IOC=$(IOC_PV),IOCNAME=$(IOCNAME)" )
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),COM_TYPE=termSrv,COM_PORT=$$SER:$$PORT" )
dbLoadRecords( "db/devIocInfo.db", "$(DEV_INFO)" )

# Initialize IP Asyn support
drvAsynIPPortConfigure("$$ASYN","$$SER:$$PORT",0,0,0)
#asynSetTraceFile( "$$ASYN", 0, "$(IOC_DATA)/$(IOC)/iocInfo/asyn-$$NAME.log" )
asynSetTraceMask( "$$ASYN", 0, 0x01)
asynSetTraceIOMask( "$$ASYN", 0, 0x0)

# Load record instances
dbLoadRecords( "db/asynRecord.db", "P=$$NAME,R=:asyn,PORT=$$ASYN,ADDR=0,OMAX=0,IMAX=0")
dbLoadRecords( "db/Keithley6514.db",	"EM=$$NAME,BUS=$$ASYN" )
dbLoadRecords( "db/zeroCorrect.db",     "EM=$$NAME")          
dbLoadRecords( "db/ai_hist.db",			"P=$$NAME" )

$$ENDLOOP(ETM)

# Setup autosave
dbLoadRecords( "db/save_restoreStatus.db",	"P=$(IOC_PV):" )
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(BUILD_TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "autoSettings.sav" )
set_pass1_restoreFile( "$(IOC).sav" )

#
# Initialize the IOC and start processing records
#
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req",  5,  "" )
create_monitor_set( "$(IOCNAME).req",    5,  "" )

# All IOCs should dump some common info after initial startup.
< $(IOC_COMMON)/All/post_linux.cmd
