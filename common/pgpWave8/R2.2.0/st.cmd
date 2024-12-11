#!$$IOCTOP/bin/$$IF(TARGET_ARCH,$$TARGET_ARCH,rhel7-x86_64)/pgpWave8

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

epicsEnvSet( "BUILD_TOP",    "$$TOP" )
< envPaths
epicsEnvSet( "IOCNAME",      "$$IOCNAME" )
epicsEnvSet( "ENGINEER",     "$$ENGINEER" )
epicsEnvSet( "LOCATION",     "$$LOCATION" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "$$IOC_PV" )
epicsEnvSet( "IOCTOP",       "$$IOCTOP" )
epicsEnvSet( "EPICS_PVA_AUTO_ADDR_LIST",         "TRUE" )
epicsEnvSet( "EPICS_PVAS_AUTO_BEACON_ADDR_LIST", "TRUE" )
cd( "$(IOCTOP)" )

# Set Max array size
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "$$IF(MAX_ARRAY,$$MAX_ARRAY,20000000)" )

# Specify PGP_PV
$$IF(PGP_PV)
epicsEnvSet( "PGP_PV",       "$$PGP_PV" )
$$ELSE(PGP_PV)
errlog( "Error: PGP_PV not defined" )
$$ENDIF(PGP_PV)

epicsEnvSet( "PGP_NAME",       		"WAVE8" )
epicsEnvSet( "PGP_BOARD",     		"$$IF(PGP_BOARD,$$PGP_BOARD,0)" )
epicsEnvSet( "PGP_LANE",     		"$$IF(PGP_LANE,$$PGP_LANE,0)" )
epicsEnvSet( "LCLS2_TIMING",        "$$IF(LCLS2_TIMING,$$LCLS2_TIMING,0)" )
epicsEnvSet( "ADDR_MAP_PATH",       "$$IF(ADDR_MAP_PATH,$$ADDR_MAP_PATH,cfg/wave8AddrMap.csv)" )

# Diagnostic settings
epicsEnvSet( "ST_CMD_DELAYS",		"$$IF(ST_CMD_DELAYS,$$ST_CMD_DELAYS,1)" )

# Register all support components
dbLoadDatabase( "dbd/pgpWave8.dbd" )
pgpWave8_registerRecordDeviceDriver(pdbbase)

# Bump up scanOnce queue size for evr invariant timing
#scanOnceSetQueueSize( $$IF(SCAN_ONCE_QUEUE_SIZE,$$SCAN_ONCE_QUEUE_SIZE,4000) )

$$IF(CPU_AFFINITY_SET)
# Set MCoreUtils rules for cpu affinity
mcoreThreadRuleAdd CAM_cpu * * $$CPU_AFFINITY_SET CAM.*
$$ENDIF(CPU_AFFINITY_SET)

# Set iocsh debug variables
var DEBUG_PGP_ROGUE_DEV $$IF(DEBUG_PGP_ROGUE_DEV,$$DEBUG_PGP_ROGUE_DEV,2)
var DEBUG_PGP_ROGUE_LIB $$IF(DEBUG_PGP_ROGUE_LIB,$$DEBUG_PGP_ROGUE_LIB,2)
var DEBUG_ROGUE_RECORDS $$IF(DEBUG_ROGUE_RECORDS,$$DEBUG_ROGUE_RECORDS,2)
#var DEBUG_GENICAM $$IF(DEBUG_GENICAM,$$DEBUG_GENICAM,1)
var save_restoreLogMissingRecords $$IF(save_restoreLogMissingRecords,$$save_restoreLogMissingRecords,0)
on error break

# =========================================================
# Configure an driver for the wave8
# =========================================================
# Rogue register device
# pgpRogueDevConfig( $(PGP_BOARD), $(PGP_LANE), $(ADDR_MAP_PATH), EPICS_PREFIX_FOR_PGP_REG_IO )
# PGP Rogue Datastream device device
pgpRogueDevConfig( $(PGP_BOARD), $(PGP_LANE), $(ADDR_MAP_PATH), "$$IF(PGP_REG,$$PGP_REG,)" )

#pgpLoadConfig( $(PGP_BOARD), cfg/DelayAdc.cfg, 0.0001 )

$$IF(BLDID)
Wave8BLDRegister($$BLDID)
$$ENDIF(BLDID)

# Configure and load standard wave8 camera database
#dbLoadRecords("db/pgpCamera.db", "PGP=$(PGP_PV),P=$(PGP_PV),R=:,PGP_BOARD=$(PGP_BOARD),PGP_LANE=$(PGP_LANE)" )
dbLoadRecords("db/wave8Data.db", "PGP=$(PGP_PV),P=$(PGP_PV),R=:,B=$(PGP_BOARD),L=$(PGP_LANE)" )
$$IF(PGP_REG)
dbLoadRecords("db/wave8Reg.db", "PGP=$(PGP_PV),P=$(PGP_PV),R=:,B=$(PGP_BOARD),L=$(PGP_LANE)" )
$$ENDIF(PGP_REG)
$$IF(PGP_REG2)
dbLoadRecords("db/w8-aliases.db", "PGP=$(PGP_PV),P=$(PGP_PV),R=:,B=$(PGP_BOARD),L=$(PGP_LANE)" )
$$ENDIF(PGP_REG2)
dbLoadRecords("db/AdcIntegrals.db", "PGP=$(PGP_PV),P=$(PGP_PV),R=:Fast:,B=$(PGP_BOARD),L=$(PGP_LANE)" )
dbLoadRecords("db/PgpCannedSequences.db",   "PGP=$(PGP_PV),B=$(PGP_BOARD),L=$(PGP_LANE)" )
dbLoadRecords("db/PgpChCannedSequences.db", "PGP_CH=$(PGP_PV)" )

$$IF(BLDID)
dbLoadRecords("db/bldSettings.db", "BLD=$(IOC_PV):B0,BLDNO=0" )
dbLoadRecords("db/wave8_bld.db",   "BASE=$(PGP_PV)")
$$ENDIF(BLDID)

# Load soft ioc related record instances
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/iocRelease.db",			"IOC=$(IOC_PV)" )
epicsEnvSet( "DEV_INFO", "DEV=$(PGP_PV),IOC=$(IOC_PV),IOCNAME=$(IOCNAME)" )
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),COM_TYPE=pgp,COM_PORT=Board $(PGP_BOARD) Lane $(PGP_LANE)" )
$$IF(POWER)
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),POWER=$$POWER" )
$$ENDIF(POWER)
$$IF(WEB_URL)
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),WEB_URL=$$WEB_URL" )
$$ENDIF(WEB_URL)
$$IF(CAPTAR)
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),CAPTAR=$$CAPTAR" )
$$ENDIF(CAPTAR)
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

#
# iocInit: Initialize the IOC and start processing records
#
iocInit()

$$IF(BLDID)
BldSetID(0)
# Datatype is Id_BeamMonitorBldData V1 (98), Version 1 = 65634
#             sAddr              uPort maxsize itf physid xtcid pretrigger              posttrigger        fiducial
BldConfig( "239.255.24.$$BLDID", 10148, 1512, 0, $$BLDID, 65634, "$(PGP_PV):CURRENTFID", "$(PGP_PV):YPOS", "$(PGP_PV):CURRENTFID","$(PGP_PV):SUM,$(PGP_PV):XPOS,$(PGP_PV):YPOS$$LOOP(8),$(PGP_PV):AMPL_$$(INDEX)$$ENDLOOP(8)$$LOOP(8),$(PGP_PV):AMPL_dummy$$ENDLOOP(8)$$LOOP(8),$(PGP_PV):TPOS_$$(INDEX)$$ENDLOOP(8)$$LOOP(8),$(PGP_PV):TPOS_dummy$$ENDLOOP(8)" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
$$(NOBLD)BldStart()
BldShowConfig()
$$ENDIF(BLDID)

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

$$IF(AUTO_START)
# Final delay before auto-start image acquisition
epicsThreadSleep 3
dbpf $(PGP_PV):SeqStartRun.PROC $$AUTO_START
$$ENDIF(AUTO_START)
var DEBUG_PGP_ROGUE_LIB $$IF(DEBUG_PGP_ROGUE_LIB,$$DEBUG_PGP_ROGUE_LIB,2)
