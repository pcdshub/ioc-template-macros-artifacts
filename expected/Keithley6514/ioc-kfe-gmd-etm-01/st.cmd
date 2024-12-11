#!/cds/group/pcds/epics/ioc/common/Keithley6514/R1.9.4/bin/rhel7-x86_64/Keithley6514

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

< envPaths
epicsEnvSet( "IOCNAME",      "ioc-kfe-gmd-etm-01" )
epicsEnvSet( "ENGINEER",     "Bruce Hill (bhill)" )
epicsEnvSet( "LOCATION",     "B930-006-K0S11-ETM-01" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "EM1K0:GMD:IOC:ETM:01" )
epicsEnvSet( "IOCTOP",       "/cds/group/pcds/epics/ioc/common/Keithley6514/R1.9.4" )
epicsEnvSet( "BUILD_TOP",    "/cds/group/pcds/epics/ioc/common/Keithley6514/R1.9.4/children/build" )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOCTOP)/db" )

cd( "$(IOCTOP)" )

# Set Max array size
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "20000000" )

# Register all support components
dbLoadDatabase("dbd/Keithley6514.dbd")
Keithley6514_registerRecordDeviceDriver(pdbbase)

# Load soft ioc related record instances
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/iocRelease.db",			"IOC=$(IOC_PV)" )

# Configure the Electrometer

epicsEnvSet( "DEV_INFO", "DEV=EM1K0:GMD:ETM:01,IOC=$(IOC_PV),IOCNAME=$(IOCNAME)" )
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),COM_TYPE=termSrv,COM_PORT=ser-kfe-gmd-01:2101" )
dbLoadRecords( "db/devIocInfo.db", "$(DEV_INFO)" )

# Initialize IP Asyn support
drvAsynIPPortConfigure("S1","ser-kfe-gmd-01:2101",0,0,0)
#asynSetTraceFile( "S1", 0, "$(IOC_DATA)/$(IOC)/iocInfo/asyn-EM1K0:GMD:ETM:01.log" )
asynSetTraceMask( "S1", 0, 0x01)
asynSetTraceIOMask( "S1", 0, 0x0)

# Load record instances
dbLoadRecords( "db/asynRecord.db", "P=EM1K0:GMD:ETM:01,R=:asyn,PORT=S1,ADDR=0,OMAX=0,IMAX=0")
dbLoadRecords( "db/Keithley6514.db",	"EM=EM1K0:GMD:ETM:01,BUS=S1" )
dbLoadRecords( "db/zeroCorrect.db",     "EM=EM1K0:GMD:ETM:01")          
dbLoadRecords( "db/ai_hist.db",			"P=EM1K0:GMD:ETM:01" )


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
