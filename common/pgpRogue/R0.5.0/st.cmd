#!$$IOCTOP/bin/$$IF(TARGET_ARCH,$$TARGET_ARCH,rhel7-x86_64)/pgpRogue

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
epicsEnvSet( "EPICS_PVA_AUTO_ADDR_LIST",         "TRUE" )
epicsEnvSet( "EPICS_PVAS_AUTO_BEACON_ADDR_LIST", "TRUE" )
cd( "$(IOCTOP)" )

# Set Max array size
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "$$IF(MAX_ARRAY,$$MAX_ARRAY,20000000)" )

# Specify PGP_PV
$$IF(PGP_PV)
epicsEnvSet( "PGP_PV",       "$$PGP_PV" )
$$ELSE(PGP_PV)
errlog( "PGP_PV not defined" )
$$ENDIF(PGP_PV)

# Specify PGP_PORT
epicsEnvSet( "PGP_PORT",     "$$IF(PGP_PORT,$$PGP_PORT,PGP)" )

# Default pgpCamlinkDriver settings
epicsEnvSet( "PGP_BOARD",    "$$IF(BOARD,$$BOARD,0)" )
epicsEnvSet( "PGP_LANE",     "$$IF(LANE,$$LANE,0)" )
epicsEnvSet( "CAM_MODE",     "$$IF(MODE,$$MODE,Base)" )
epicsEnvSet( "LCLS2_TIMING", "$$IF(LCLS2_TIMING,$$LCLS2_TIMING,0)" )

# Register all support components
dbLoadDatabase( "dbd/pgpRogue.dbd" )
pgpRogue_registerRecordDeviceDriver(pdbbase)

# Bump up scanOnce queue size for evr invariant timing
#scanOnceSetQueueSize( $$IF(SCAN_ONCE_QUEUE_SIZE,$$SCAN_ONCE_QUEUE_SIZE,4000) )

$$IF(CPU_AFFINITY_SET)
# Set MCoreUtils rules for cpu affinity
mcoreThreadRuleAdd CAM_cpu * * $$CPU_AFFINITY_SET CAM.*
$$ENDIF(CPU_AFFINITY_SET)

# Set iocsh debug variables
var DEBUG_ROGUE_DEV $$IF(DEBUG_ROGUE_DEV,$$DEBUG_ROGUE_DEV,1)
var DEBUG_PGP_ROGUE $$IF(DEBUG_PGP_ROGUE,$$DEBUG_PGP_ROGUE,1)
var save_restoreLogMissingRecords $$IF(save_restoreLogMissingRecords,$$save_restoreLogMissingRecords,0)
var dbLoadSuspendOnError $$IF(dbLoadSuspendOnError,$$dbLoadSuspendOnError,1)

# =========================================================
# Configure an pgpCamlink driver for the specified camera model
# =========================================================
epicsEnvSet( "EVR_TYPE", "pgpRogue" )
rogueDevConfig(  "$(PGP_PORT)",     "$(PGP_BOARD)", "$(LCLS2_TIMING)" )

#
# Load devRogue PVs (Read/Write of PGP registers by varPath via Rogue Library)
dbLoadRecords("db/ClinkPcie.template",	"P=$(PGP_PV),R=:,B=$(PGP_BOARD),L=0")
dbLoadRecords("db/roguePcie.db",		"P=$(PGP_PV),R=:,B=$(PGP_BOARD),L=0,F=0")

# Camera Lane 0
dbLoadRecords("db/TriggerEventManager.template",	"P=$(PGP_PV),R=:Ch0:,B=$(PGP_BOARD),L=0,F=0,FL=0")
dbLoadRecords("db/ClinkFeb.template",	"P=$(PGP_PV),R=:Ch0:,B=$(PGP_BOARD),L=0,F=0,FL=0")
dbLoadRecords("db/ClinkLane.db",		"P=$(PGP_PV),R=:Ch0:,B=$(PGP_BOARD),L=0,F=0,FL=0")

# Camera Lane 1
dbLoadRecords("db/TriggerEventManager.template",	"P=$(PGP_PV),R=:Ch1:,B=$(PGP_BOARD),L=1,F=1,FL=0")
dbLoadRecords("db/ClinkFeb.template",	"P=$(PGP_PV),R=:Ch1:,B=$(PGP_BOARD),L=1,F=1,FL=0")
dbLoadRecords("db/ClinkLane.db",		"P=$(PGP_PV),R=:Ch1:,B=$(PGP_BOARD),L=1,F=1,FL=0")

# Camera Lane 2
dbLoadRecords("db/TriggerEventManager.template",	"P=$(PGP_PV),R=:Ch2:,B=$(PGP_BOARD),L=2,F=2,FL=0")
dbLoadRecords("db/ClinkFeb.template",	"P=$(PGP_PV),R=:Ch2:,B=$(PGP_BOARD),L=2,F=2,FL=0")
dbLoadRecords("db/ClinkLane.db",		"P=$(PGP_PV),R=:Ch2:,B=$(PGP_BOARD),L=2,F=2,FL=0")

# Camera Lane 3
dbLoadRecords("db/TriggerEventManager.template",	"P=$(PGP_PV),R=:Ch3:,B=$(PGP_BOARD),L=3,F=3,FL=0")
dbLoadRecords("db/ClinkFeb.template",	"P=$(PGP_PV),R=:Ch3:,B=$(PGP_BOARD),L=3,F=3,FL=0")
dbLoadRecords("db/ClinkLane.db",		"P=$(PGP_PV),R=:Ch3:,B=$(PGP_BOARD),L=3,F=3,FL=0")

# Load records for various configuration sequences
dbLoadRecords("db/PgpCannedSequences.db",	"PGP=$(PGP_PV)")
dbLoadRecords("db/PgpChCannedSequences.db",	"PGP=$(PGP_PV),CH=0")
dbLoadRecords("db/PgpChCannedSequences.db",	"PGP=$(PGP_PV),CH=1")
dbLoadRecords("db/PgpChCannedSequences.db",	"PGP=$(PGP_PV),CH=2")
dbLoadRecords("db/PgpChCannedSequences.db",	"PGP=$(PGP_PV),CH=3")

# Load soft ioc related record instances
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/iocRelease.db",			"IOC=$(IOC_PV)" )
epicsEnvSet( "DEV_INFO", "DEV=$(PGP_PV),IOC=$(IOC_PV),IOCNAME=$(IOCNAME)" )
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),COM_TYPE=pciE,COM_PORT=Board $(PGP_BOARD)" )
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
dbLoadRecords( "db/save_restoreStatus.db",	"P=$(IOC_PV):SR:,IOC=$(IOC_PV)" )
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(BUILD_TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
#- pass0 autosave restore IS needed for cameras
set_pass0_restoreFile( "autoSettings.sav" )
#- Is pass1 needed?  slows IOC boot
#-set_pass1_restoreFile( "autoSettings.sav" )

#
# iocInit: Initialize the IOC and start processing records
#
iocInit()

# iocInit done

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req",  5,  "" )

# All IOCs should dump some common info after initial startup.
< $(IOC_COMMON)/All/post_linux.cmd

#- TODO: Remove these dbpf calls if possible
dbpf $(PGP_PV):LAUNCH_EDM "$$TOP/iocBoot/$(IOCNAME)/edm-$(IOCNAME).cmd"

var DEBUG_ROGUE_DEV $$IF(DEBUG_ROGUE_DEV,$$DEBUG_ROGUE_DEV,1)
var DEBUG_PGP_ROGUE $$IF(DEBUG_PGP_ROGUE,$$DEBUG_PGP_ROGUE,1)

#dbpf $(PGP_PV):Feb0:FCh0:FrameCount_RBV.TPRO 2
#dbpf $(PGP_PV):Feb0:FCh0:FrameCount_RBV.PROC 1

# Force a read of all Rogue PGP registers
DumpPgpVars $(PGP_PORT) /reg/d/iocData/$(IOCNAME)/dumpreg-EPICS-LCLS1-boot.txt 0 1
DumpPgpVars $(PGP_PORT) /reg/d/iocData/$(IOCNAME)/cfgreg-EPICS-LCLS1-boot.txt 1 1
