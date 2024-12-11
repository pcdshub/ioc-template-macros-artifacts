#!/reg/g/pcds/epics/ioc/common/axiRogue/R0.2.1/bin/rhel7-x86_64/axiRogue

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

< envPaths
epicsEnvSet( "IOCNAME",      "ioc-kfe-rogue1" )
epicsEnvSet( "ENGINEER",     "Bruce Hill (bhill)" )
epicsEnvSet( "LOCATION",     "B940, R06, E26 KFE Hutch" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "IM0K0:IOC:ROGUE1" )
epicsEnvSet( "IOCTOP",       "/reg/g/pcds/epics/ioc/common/axiRogue/R0.2.1" )
epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/common/axiRogue/R0.2.1/children/build" )
epicsEnvSet( "EPICS_PVA_AUTO_ADDR_LIST",         "TRUE" )
epicsEnvSet( "EPICS_PVAS_AUTO_BEACON_ADDR_LIST", "TRUE" )
cd( "$(IOCTOP)" )

# Set Max array size
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "20000000" )

# Specify AXI_PV
epicsEnvSet( "AXI_PV",       "IM0K0:PGP:ROGUE1" )

# Specify AXI_PORT
epicsEnvSet( "AXI_PORT",     "PGP" )

# Default pgpCamlinkDriver settings
epicsEnvSet( "PGP_PV",       "$(AXI_PV)" )
epicsEnvSet( "PGP_BOARD",    "0" )
epicsEnvSet( "PGP_LANE",     "0" )
epicsEnvSet( "CAM_MODE",     "Base" )
epicsEnvSet( "LCLS2_TIMING", "0" )

# Register all support components
dbLoadDatabase( "dbd/axiRogue.dbd" )
axiRogue_registerRecordDeviceDriver(pdbbase)

# Bump up scanOnce queue size for evr invariant timing
#scanOnceSetQueueSize( 4000 )


# Set iocsh debug variables
var DEBUG_ROGUE_DEV 1
var DEBUG_AXI_ROGUE 1
var save_restoreLogMissingRecords 0
var dbLoadSuspendOnError 1

# =========================================================
# Configure an pgpCamlink driver for the specified camera model
# =========================================================
epicsEnvSet( "EVR_TYPE", "axiRogue" )
rogueDevConfig(  "$(AXI_PORT)",     "$(PGP_BOARD)", "$(LCLS2_TIMING)" )

#
# Load devRogue PVs (Read/Write of PGP registers by varPath via Rogue Library)
dbLoadRecords("db/ClinkPcie.template",	"P=$(AXI_PV),R=:,B=$(PGP_BOARD),L=0")
dbLoadRecords("db/roguePcie.db",		"P=$(AXI_PV),R=:,B=$(PGP_BOARD),L=0,F=0")

# Camera Lane 0
dbLoadRecords("db/TriggerEventManager.template",	"P=$(AXI_PV),R=:Ch0:,B=$(PGP_BOARD),L=0,F=0,FL=0")
dbLoadRecords("db/ClinkFeb.template",	"P=$(AXI_PV),R=:Ch0:,B=$(PGP_BOARD),L=0,F=0,FL=0")
dbLoadRecords("db/ClinkLane.db",		"P=$(AXI_PV),R=:Ch0:,B=$(PGP_BOARD),L=0,F=0,FL=0")

# Camera Lane 1
dbLoadRecords("db/TriggerEventManager.template",	"P=$(AXI_PV),R=:Ch1:,B=$(PGP_BOARD),L=1,F=1,FL=0")
dbLoadRecords("db/ClinkFeb.template",	"P=$(AXI_PV),R=:Ch1:,B=$(PGP_BOARD),L=1,F=1,FL=0")
dbLoadRecords("db/ClinkLane.db",		"P=$(AXI_PV),R=:Ch1:,B=$(PGP_BOARD),L=1,F=1,FL=0")

# Camera Lane 2
dbLoadRecords("db/TriggerEventManager.template",	"P=$(AXI_PV),R=:Ch2:,B=$(PGP_BOARD),L=2,F=2,FL=0")
dbLoadRecords("db/ClinkFeb.template",	"P=$(AXI_PV),R=:Ch2:,B=$(PGP_BOARD),L=2,F=2,FL=0")
dbLoadRecords("db/ClinkLane.db",		"P=$(AXI_PV),R=:Ch2:,B=$(PGP_BOARD),L=2,F=2,FL=0")

# Camera Lane 3
dbLoadRecords("db/TriggerEventManager.template",	"P=$(AXI_PV),R=:Ch3:,B=$(PGP_BOARD),L=3,F=3,FL=0")
dbLoadRecords("db/ClinkFeb.template",	"P=$(AXI_PV),R=:Ch3:,B=$(PGP_BOARD),L=3,F=3,FL=0")
dbLoadRecords("db/ClinkLane.db",		"P=$(AXI_PV),R=:Ch3:,B=$(PGP_BOARD),L=3,F=3,FL=0")

# Load records for various configuration sequences
dbLoadRecords("db/AxiCannedSequences.db",	"AXI=$(AXI_PV)")
dbLoadRecords("db/AxiChCannedSequences.db",	"AXI=$(AXI_PV),CH=0")
dbLoadRecords("db/AxiChCannedSequences.db",	"AXI=$(AXI_PV),CH=1")
dbLoadRecords("db/AxiChCannedSequences.db",	"AXI=$(AXI_PV),CH=2")
dbLoadRecords("db/AxiChCannedSequences.db",	"AXI=$(AXI_PV),CH=3")

# Load soft ioc related record instances
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/iocRelease.db",			"IOC=$(IOC_PV)" )
epicsEnvSet( "DEV_INFO", "DEV=$(AXI_PV),IOC=$(IOC_PV),IOCNAME=$(IOCNAME)" )
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),COM_TYPE=pciE,COM_PORT=Board $(PGP_BOARD)" )
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
dbpf $(AXI_PV):LAUNCH_EDM "/reg/g/pcds/epics/ioc/common/axiRogue/R0.2.1/children/build/iocBoot/$(IOCNAME)/edm-$(IOCNAME).cmd"

var DEBUG_ROGUE_DEV 1
var DEBUG_AXI_ROGUE 1

#dbpf $(AXI_PV):Feb0:FCh0:FrameCount_RBV.TPRO 2
#dbpf $(AXI_PV):Feb0:FCh0:FrameCount_RBV.PROC 1

# Force a read of all Rogue PGP registers
DumpPgpVars $(AXI_PORT) /reg/d/iocData/$(IOCNAME)/dumpreg-EPICS-LCLS1-boot.txt 0 1
DumpPgpVars $(AXI_PORT) /reg/d/iocData/$(IOCNAME)/cfgreg-EPICS-LCLS1-boot.txt 1 1
