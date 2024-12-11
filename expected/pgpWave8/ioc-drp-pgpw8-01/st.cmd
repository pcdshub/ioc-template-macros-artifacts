#!/cds/group/pcds/epics/ioc/common/pgpWave8/R2.5.0/bin/rhel7-x86_64/pgpWave8

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

epicsEnvSet( "BUILD_TOP",    "/cds/group/pcds/epics/ioc/common/pgpWave8/R2.5.0/children/build" )
< envPaths
epicsEnvSet( "IOCNAME",      "ioc-drp-pgpw8-01" )
epicsEnvSet( "ENGINEER",     "Tyler Johnson (tjohnson)" )
epicsEnvSet( "LOCATION",     "Bldg 940-09, NEH FEE Rack Room" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "DAQ:TST:W8:IOC:01" )
epicsEnvSet( "IOCTOP",       "/cds/group/pcds/epics/ioc/common/pgpWave8/R2.5.0" )
epicsEnvSet( "EPICS_PVA_AUTO_ADDR_LIST",         "TRUE" )
epicsEnvSet( "EPICS_PVAS_AUTO_BEACON_ADDR_LIST", "TRUE" )
cd( "$(IOCTOP)" )

# Set Max array size
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "20000000" )

# Specify PGP_PV
epicsEnvSet( "PGP_PV",       "DAQ:TST:W8:01" )

epicsEnvSet( "PGP_NAME",       		"WAVE8" )
epicsEnvSet( "PGP_BOARD",     		"0" )
epicsEnvSet( "PGP_LANE",     		"2" )
epicsEnvSet( "LCLS2_TIMING",        "0" )
epicsEnvSet( "ADDR_MAP_PATH",       "cfg/wave8AddrMap.csv" )

# Diagnostic settings
epicsEnvSet( "ST_CMD_DELAYS",		"1" )

# Register all support components
dbLoadDatabase( "dbd/pgpWave8.dbd" )
pgpWave8_registerRecordDeviceDriver(pdbbase)

# Bump up scanOnce queue size for evr invariant timing
#scanOnceSetQueueSize( 4000 )


# Set iocsh debug variables
var DEBUG_PGP_ROGUE_DEV 2
var DEBUG_PGP_ROGUE_LIB 2
var DEBUG_ROGUE_RECORDS 2
#var DEBUG_GENICAM 1
var save_restoreLogMissingRecords 0
on error break

# =========================================================
# Configure an driver for the wave8
# =========================================================
# Rogue register device
# pgpRogueDevConfig( $(PGP_BOARD), $(PGP_LANE), $(ADDR_MAP_PATH), EPICS_PREFIX_FOR_PGP_REG_IO )
# PGP Rogue Datastream device device
pgpRogueDevConfig( $(PGP_BOARD), $(PGP_LANE), $(ADDR_MAP_PATH), "DAQ:TST:W8:01" )

#pgpLoadConfig( $(PGP_BOARD), cfg/DelayAdc.cfg, 0.0001 )


# Configure and load standard wave8 camera database
#dbLoadRecords("db/pgpCamera.db", "PGP=$(PGP_PV),P=$(PGP_PV),R=:,PGP_BOARD=$(PGP_BOARD),PGP_LANE=$(PGP_LANE)" )
dbLoadRecords("db/wave8Data.db", "PGP=$(PGP_PV),P=$(PGP_PV),R=:,B=$(PGP_BOARD),L=$(PGP_LANE)" )
dbLoadRecords("db/wave8Reg.db", "PGP=$(PGP_PV),P=$(PGP_PV),R=:,B=$(PGP_BOARD),L=$(PGP_LANE)" )
dbLoadRecords("db/AdcIntegrals.db", "PGP=$(PGP_PV),P=$(PGP_PV),R=:Fast:,B=$(PGP_BOARD),L=$(PGP_LANE)" )
dbLoadRecords("db/PgpCannedSequences.db",   "PGP=$(PGP_PV),B=$(PGP_BOARD),L=$(PGP_LANE)" )
dbLoadRecords("db/PgpChCannedSequences.db", "PGP_CH=$(PGP_PV)" )


# Load soft ioc related record instances
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/iocRelease.db",			"IOC=$(IOC_PV)" )
epicsEnvSet( "DEV_INFO", "DEV=$(PGP_PV),IOC=$(IOC_PV),IOCNAME=$(IOCNAME)" )
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),COM_TYPE=pgp,COM_PORT=Board $(PGP_BOARD) Lane $(PGP_LANE)" )
dbLoadRecords( "db/devIocInfo.db",			"$(DEV_INFO)" )

# Setup autosave
dbLoadRecords( "db/save_restoreStatus.db",	"P=$(IOC_PV):" )
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(BUILD_TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
#- pass0 autosave restore IS needed for cameras
set_pass0_restoreFile( "autoSettings.sav" )
#- Without pass1, we don't get the BLD configuration parameters saved.
set_pass1_restoreFile( "autoSettings.sav" )

# Configure access security: this is required for caPutLog.
asSetFilename("$(TOP)/iocBoot/templates/unrestricted.acf")

#
# iocInit: Initialize the IOC and start processing records
#
iocInit()

# caPutLogInit("HOST:PORT", config)
# config options:
#       caPutLogNone       -1: no logging (disable)
#       caPutLogOnChange    0: log only on value change
#       caPutLogAll         1: log all puts
#       caPutLogAllNoFilter 2: log all puts no filtering on same PV
caPutLogInit("${EPICS_CA_PUT_LOG_ADDR}", 0)


# iocInit done

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req",  5,  "" )

# Update archive file
system( "cp $(BUILD_TOP)/archive/$(IOC).archive $(IOC_DATA)/$(IOC)/archive/$(IOC).archive" ) 

# All IOCs should dump some common info after initial startup.
< $(IOC_COMMON)/All/post_linux.cmd

dbpf $(PGP_PV):LAUNCH_EDM "$(BUILD_TOP)/iocBoot/$(IOCNAME)/edm-$(IOCNAME).cmd"

# Initiate AdcCalibration
dbpf $(PGP_PV):AdcCalibration.PROC 1

# Final delay before auto-start image acquisition
epicsThreadSleep 3
dbpf $(PGP_PV):SeqStartRun.PROC 1
var DEBUG_PGP_ROGUE_LIB 2
